module ApplicationHelper

  # formate le nombre en Euros
  def number_to_euros(number)
    return number_to_currency(number, unit: "€", separator: ",", format: "%n %u")
  end

  def current_cart
    current_user ? Cart.find_by(user_id: current_user.id) : false
  end

  def item_already_in_cart?(item_id)
    CartItem.find_by(cart_id: current_cart.id, item_id: item_id)
  end

  def admin?
    user_signed_in? && current_user.admin
  end
end
