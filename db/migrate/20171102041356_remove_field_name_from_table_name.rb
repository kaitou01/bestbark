class RemoveFieldNameFromTableName < ActiveRecord::Migration[5.1]
  def change
    remove_column :line_items, :product_id, :integer
  end
end
