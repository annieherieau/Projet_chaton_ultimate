class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  
  def show
    @orders = Order.where(user_id: @user.id)
  end

  private

  def set_user
    @user = current_user 
  end
end