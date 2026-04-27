class RenameStyleInBeers < ActiveRecord::Migration[8.1]
  def change
    rename_column :beers, :style, :old_style
  end
end
