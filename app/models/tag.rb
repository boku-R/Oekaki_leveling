class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  # タグは複数の投稿を持ち、post_tagsを通じて参照できる
  has_many :posts, through: :post_tags

  validates :name, uniqueness: true, presence: true

  # 検索
  def self.looks(word)
    @tag = Tag.where("name LIKE?","%#{word}%")
  end

end
