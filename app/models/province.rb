class Province < ApplicationRecord
  validates :name, :gst, :pst, :hst, presence:true
end
