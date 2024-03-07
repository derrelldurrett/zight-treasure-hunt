class AddWinnerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :winner, :boolean
  end
end
