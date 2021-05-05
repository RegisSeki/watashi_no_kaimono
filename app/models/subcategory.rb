class Subcategory < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :category, presence: true

  has_many :products
  belongs_to :category
end
