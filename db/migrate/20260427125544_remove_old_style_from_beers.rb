class RemoveOldStyleFromBeers < ActiveRecord::Migration[8.1]
  def change
    remove_column :beers, :old_style, :string
  end
end
