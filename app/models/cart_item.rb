class CartItem < ApplicationRecord

  #table 1-N
  belongs_to :cart

  #table 1-N
  belongs_to :item
end
