class Province < ApplicationRecord
  has_many :customers

  validates :name, :gst, :pst, :hst, presence: true
  validates :name, uniqueness: true
end
