class CreateListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :list_items do |t|
      t.references :shopping_list, index: true, foreign_key: true, null: false
      t.references :product, index: true, foreign_key: true, null: false
      t.float :required_quantity, null: false, :default => 1
      t.float :purchased_quantity
      t.float :price
      t.index [:shopping_list_id, :product_id]

      t.timestamps
    end
  end
end
