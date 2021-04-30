class RemoveCategoryReferencesFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :products, :category
  end
end
