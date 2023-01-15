class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  # タグは複数の投稿を持ち、post_tagsを通じて参照できる
  has_many :posts, through: :post_tags

  validates :name, uniqueness: true, presence: true

  # 検索
  def self.looks(word)
    @tag = Tag.where("name LIKE?","%#{word}%")
  end

  # Tagに紐づくPostを統合し「.joins(:posts)」、Postが論理削除されていないようなタグを絞り込み「.merge(Post.where(is_deleted: false))」、重複をはじく「.distinct」
  def self.using_tags
    @tag = Tag.joins(:posts).merge(Post.where(is_deleted: false)).distinct
  end

end
