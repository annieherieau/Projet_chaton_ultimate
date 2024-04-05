class Order < ApplicationRecord
  # table N-1
  belongs_to :user

  # table N-N through
  has_many :order_items
  has_many :items, through: :order_items

  def send_order_emails
    admins = User.where(admin: true)
    admins.each do |admin|
      UserMailer.order_to_admin(admin, self).deliver_now
    end
    UserMailer.order_to_user(self).deliver_now
  end

  def amount
    amount = 0;
    self.items.each{ |item| amount += item.price }
    return amount
  end

  def add_items(item_ids)
    item_ids.each do |item_id| 
      OrderItem.create!(order_id: self.id, item_id: item_id)
    end
  end

end
