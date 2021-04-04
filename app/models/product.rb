class Product < ApplicationRecord
	validates :name, presence: true, length: { minimum: 3 }
	validates :category, presence: true, length: { minimum: 3 }
end
