class AddTokenDateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token_date, :datetime
  end
end
