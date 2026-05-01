class AddActivityToBrewery < ActiveRecord::Migration[8.1]
  def change
    add_column :breweries, :active, :boolean
  end
end
