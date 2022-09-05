class User < ApplicationRecord
  has_many :articles

  validates :username, presence: true, length: {in: 3..20}, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
