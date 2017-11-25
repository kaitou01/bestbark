# Customer model
class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :nullify

  validates :name, :address, :city,
            :postal_code, :province_id, presence: true
end
