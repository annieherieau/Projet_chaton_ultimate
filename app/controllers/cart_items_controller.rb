class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: %i[ create destroy ]
  
  def create
    if !@cart_item
      @cart_item = CartItem.new(
        cart_id: params[:cart_id], 
        item_id: params[:item_id]
      )

      if @cart_item.save
        redirect_to request.referrer, notice: "L'article a été ajouté à votre panier."
      else
        redirect_to request.referrer
      end
    end
  end

  def destroy
    cart_id = @cart_item.cart_id
    if @cart_item.destroy!
      # redirect_to cart_path(cart_id), notice: "L'article a été supprimé."
      redirect_to request.referrer, notice: "L'article a été supprimé."
    else
      redirect_to request.referrer, alert: "Une erreur est survenue: l'article n'a pas été supprimé."
    end
  end

  private
  def set_cart_item
    @cart_item = CartItem.find_by(cart_id: params[:cart_id], item_id: params[:item_id])
  end

end
