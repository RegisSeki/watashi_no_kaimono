class CreateShoppingList < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_lists do |t|
      t.string :name, null: false
      t.string :status, null: false, :default => 'opened'
      t.references :user, index: true, foreign_key: true, null: false
      t.index [:user_id, :name], unique: true

      t.timestamps
    end
  end
end
