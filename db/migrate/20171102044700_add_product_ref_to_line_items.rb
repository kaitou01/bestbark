# AddProductRefToLineItems Migration
class AddProductRefToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :line_items, :product, foreign_key: true
  end
end
