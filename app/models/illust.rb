class Illust < ApplicationRecord

  has_many :favorites, dependent: :destroy
  belongs_to :post

  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :illust_image

  # ユーザのアイコン画像アップロードに対してのバリデーション(.jpg .jpeg .pngのみ許可)
  validate :illust_image_type

  # enumの定義
  enum step: { draft: 0, linedraw: 1, color: 2, finish: 3}

  # ユーザがファボっているか判定するメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private

  def illust_image_type
    if illust_image.blob
      if !illust_image.blob.content_type.in?(%('image/jpeg image/jpg image/png'))
          errors.add(:illust_image, 'はjpeg、jpgまたはpng形式でアップロードしてください')
      end
    end
  end

end
