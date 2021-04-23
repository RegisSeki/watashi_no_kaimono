class User < ApplicationRecord
  validates :password, length: { minimum: 6 }, allow_nil: true
  has_secure_password

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
