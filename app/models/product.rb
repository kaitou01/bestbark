class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  has_many :orders, :through => :line_items

  validates :name, :description, :price, :quantity, presence: true
end
