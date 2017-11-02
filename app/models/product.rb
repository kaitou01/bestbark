class Product < ApplicationRecord
  validates :name, :description, :price, :quantity, presence: true
end
