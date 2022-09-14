class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_save {self.email = email.downcase}

  validates :username, presence: true, length: {in: 3..20}, uniqueness: true
  validates :password, presence: true



  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }

  # has_secure_password
end
