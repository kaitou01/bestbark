class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  has_many :orders, :through => :line_items

  validates :name, :description, :price, :quantity, :category_id, presence: true
  validates :name, uniqueness: true
end
