class Post < ApplicationRecord

  belongs_to :user

  has_many :illusts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  accepts_nested_attributes_for :illusts
  # タグに対するリレーション
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  validates :title, presence: true

  # 検索
  def self.looks(word)
      @post = Post.where("title LIKE?","%#{word}%")
  end

  # タグについて
  def save_tag(sent_tags)
    # タグが存在すれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 取得したタグから送られてきたタグを除いて、oldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから、既に存在するタグを除いたタグをnew_tagとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

end
