class Order < ApplicationRecord
  validates :status, :pst_rate, :gst_rate, :hst_rate, presence: true
end
