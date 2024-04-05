class Item < ApplicationRecord
  has_many :carts, through: :cart_items

  # table N-N through
  has_many :order_items
  has_many :orders, through: :order_items

  # Active Storage
  has_one_attached :photo

  # validations
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price,  presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  
end
