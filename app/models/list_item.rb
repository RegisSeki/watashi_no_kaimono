class ListItem < ApplicationRecord
  validates :required_quantity, presence: true
  validates :shopping_list, presence: true
  validates :product, presence: true

  belongs_to :shopping_list
  belongs_to :product

  def self.load_items(shopping_list_id)
    self.where("shopping_list_id = ?", shopping_list_id)
  end

  def self.find_item(shopping_list_id, product_id)
    self.where("shopping_list_id =? AND product_id = ?", shopping_list_id, product_id)
  end
end
