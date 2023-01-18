class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :profile_image

  # 投稿への関連付け
  has_many :posts, dependent: :destroy

  # いいねへの関連付け
  has_many :favorites, dependent: :destroy

  # PostCommentに対する関連付け
  has_many :post_comments, dependent: :destroy

  # 下記フォロー機能
  # フォローをした、されたの関係を実装
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使うための実装
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 下記フォロー機能におけるメソッドの記述
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # ユーザ名に一意性を持たせ、半角英数字のみ許可
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\z/i }

  # ユーザのアイコン画像アップロードに対してのバリデーション(.jpg .jpeg .pngのみ許可)
  validate :profile_image_type

  # プロフィール画像を取得するためのメソッド
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  # ゲストログインのためのメソッドを定義
  def self.guest
    find_or_create_by!(username: 'guestuser', email:'guest@example.com', handlename:'ゲストユーザー')do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "guestuser"
    end
  end

  # 検索
  def self.looks(word)
      @user = User.where(['username LIKE? OR handlename LIKE?',"%#{word}%", "%#{word}%"])
  end

  private

  # アップロードされた画像データに対するバリデーション
  def profile_image_type
    if profile_image.blob
      if !profile_image.blob.content_type.in?(%('image/jpeg image/jpg image/png'))
          errors.add(:profile_image, 'はjpeg、jpgまたはpng形式でアップロードしてください')
      end
    end
  end

end