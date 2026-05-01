class AddClosedToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :closed, :boolean
  end
end
