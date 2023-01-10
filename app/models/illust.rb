class Illust < ApplicationRecord

  has_many :favorites, dependent: :destroy
  belongs_to :post

  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :illust_image

end
