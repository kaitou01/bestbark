# Product model
class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  has_many :orders, through: :line_items

  validates :name, :description, :price, :quantity, :category_id, presence: true
  validates :name, uniqueness: true

  def self.search(search, category)
  if search
    if category != ''
      order(:name).where('name LIKE ?', "%#{search}%").where('category_id = ?', category)
    else
      order(:name).where('name LIKE ?', "%#{search}%")
    end
  else
    order(:name)
  end
end
end
