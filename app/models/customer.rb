class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :name, :username, :password, :address, :city, :postal_code, :province_id presence: true
  validates :username, uniqueness: true
end
