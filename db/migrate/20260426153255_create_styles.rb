class CreateStyles < ActiveRecord::Migration[8.1]
  def change
    create_table :styles do |t|
      t.text :name

      t.timestamps
    end
  end
end
