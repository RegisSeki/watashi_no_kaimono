class AddCategoriesToSubcategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :subcategories, :category, index: true, foreign_key: true
  end
end
