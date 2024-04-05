class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show update ]
  before_action :authenticate_user!

  # def create
  #   @cart = Cart.new(
  #     user_id: current_user.id
  #   )
  # end

  # GET /carts/1
  def show
    # redirection si user n'est pas le propriétaire du panier
    redirect_to root_path if current_user != @cart.user
  end

  # PATCH/PUT /carts/1
  def update
    @cart.drop
    redirect_to cart_url(@cart), notice: "Votre panier a été vidé !" 
  end

    # Méthode pour récupérer le nombre d'articles dans le panier
    def count_items
      @cart_items_count = current_user.cart_items.count
    end

  private
  def set_cart
    @cart = Cart.find(params[:id])
  end

end
