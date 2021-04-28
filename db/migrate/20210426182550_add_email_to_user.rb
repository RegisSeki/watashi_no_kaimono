class AddEmailToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string
    add_column :users, :valid_email, :boolean
  end
end
