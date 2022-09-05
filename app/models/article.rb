class Article < ApplicationRecord
  # belongs_to :user, optonal: true
  belongs_to :user
  validates :user_id, presence: true
  before_save :convert_lower_case

  def convert_lower_case
    self.author.downcase!
  end

  # validate :is_user_exist, if: :user_id
  # private
  # def is_user_exist
  #   errors.add(:user_id, 'is invalid') unless User.exists?(self.user_id)
  # end

end
