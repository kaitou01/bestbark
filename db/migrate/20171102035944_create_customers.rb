# CreateCustomers Migration
class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :username
      t.string :password
      t.string :address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
