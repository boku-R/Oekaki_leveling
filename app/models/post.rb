class Post < ApplicationRecord

  has_many :illusts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  accepts_nested_attributes_for :illusts

  validates :title, presence: true
  
  # 検索
  def self.looks(word)
      @post = Post.where("title LIKE?","%#{word}%")
  end

end
