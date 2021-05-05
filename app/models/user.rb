class User < ApplicationRecord
  validates :password, length: { minimum: 6 },presence: true, confirmation: true, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, :on => :create
  has_secure_password

  has_many :shopping_lists

  def self.update_token_date(user_id)
    user = User.find(user_id)
    user.update(token_date: Time.zone.now)
    user.token_date
  end

  def self.is_authenticated?(user_id, date)
    user = User.find(user_id)
    user.token_date.to_s == date.to_s
  end
end
