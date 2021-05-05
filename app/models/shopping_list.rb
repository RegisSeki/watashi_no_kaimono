class ShoppingList < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates_uniqueness_of :name, :scope => :user_id

  belongs_to :user
  has_many :list_items

  def self.load_opened_lists(user_id)
    self.where("user_id = ? AND status = ?", user_id, 'opened')
  end
end
