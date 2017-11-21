# Product model
class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  has_many :orders, through: :line_items

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }

  validates :name, :description, :price, :quantity, :category_id, presence: true
  validates :name, uniqueness: true
  validates :image, :attachment_presence => true
  validates_attachment :image, :presence => true,
    :content_type => { :content_type => "image/jpeg" },
    :size => { :in => 0..200.kilobytes }

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
