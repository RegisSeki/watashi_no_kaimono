class AddSubcategoriesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :subcategory, index: true, foreign_key: true
  end
end
