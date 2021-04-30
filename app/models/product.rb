class Product < ApplicationRecord
	validates :name, presence: true, length: { minimum: 3 }
  validates :subcategory, presence: true

  belongs_to :subcategory
end
