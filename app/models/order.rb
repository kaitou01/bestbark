# Order model
class Order < ApplicationRecord
  has_many :line_items, dependent: :nullify
  has_many :products, through: :line_items
  belongs_to :customer

  validates :status, :pst_rate, :gst_rate, :hst_rate, presence: true
end
