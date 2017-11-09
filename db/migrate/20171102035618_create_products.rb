# CreateProducts Migration
class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
