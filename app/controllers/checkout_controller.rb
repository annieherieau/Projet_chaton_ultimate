class CheckoutController < ApplicationController
  def create
    @cart = Cart.find_by(id: params[:cart_id])
    @amount = @cart.total.to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@amount*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        cart_id: @cart.id
      },
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  end


  def success
    session_id = params[:session_id]
    stripe_session = Stripe::Checkout::Session.retrieve(session_id)
    cart_id = stripe_session.metadata["cart_id"]
    @user = current_user
  
    @cart = Cart.find_by(id: cart_id)
  
    if @cart
      ActiveRecord::Base.transaction do
        @order = Order.create!(user: @user)
        @order.add_items(@cart.item_ids)
        @order.send_order_emails
   
        @cart.drop
      end
    else
      Rails.logger.error "Cart not found with ID: #{cart_id}"
    end
  end
  
  

  def cancel
  end


end
