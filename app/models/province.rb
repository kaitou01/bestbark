# Province model
class Province < ApplicationRecord
  has_many :customers, dependent: :nullify

  validates :name, :gst, :pst, :hst, presence: true
  validates :name, uniqueness: true
end
