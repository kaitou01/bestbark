# CreateLineItems Migration
class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.decimal :price
      t.integer :product_id

      t.timestamps
    end
  end
end
