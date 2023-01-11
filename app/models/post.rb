class Post < ApplicationRecord

  has_many :illusts, dependent: :destroy
  accepts_nested_attributes_for :illusts

  validates :title, presence: true

end
