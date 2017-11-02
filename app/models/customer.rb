class Customer < ApplicationRecord
  validates :name, :username, :password, :address, :city, :postal_code, presence:true
end
