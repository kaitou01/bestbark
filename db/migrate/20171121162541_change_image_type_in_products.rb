class ChangeImageTypeInProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :image, :attachment
  end
end
