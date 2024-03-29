class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }

  has_many :subcategories
end
