class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # ユーザ名に一意性を持たせ、半角英数字のみ許可
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\z/i }
  validates :password, length: { minimum: 6 }
end
