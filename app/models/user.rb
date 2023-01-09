class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # ユーザ名に一意性を持たせ、半角英数字のみ許可
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\z/i }
  validates :password, length: { minimum: 6 }

  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :profile_image

  # プロフィール画像を取得するためのメソッド
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
end
