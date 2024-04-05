class OrderItem < ApplicationRecord
  #table 1-N
  belongs_to :order

  #table 1-N
  belongs_to :item
end
