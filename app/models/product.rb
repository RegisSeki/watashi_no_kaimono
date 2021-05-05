class Product < ApplicationRecord
	validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :subcategory, presence: true
  validates :code, presence: true, uniqueness: true

  belongs_to :subcategory
  has_many :list_items
end
