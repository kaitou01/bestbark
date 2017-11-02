class LineItem < ApplicationRecord
  validates :quantity, :price, presence:true
end
