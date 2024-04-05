class AdminController < ApplicationController
    before_action :authenticate_user! 
    before_action :check_admin

    def dashboard
        @orders = Order.all
        @items = Item.all
        @User = User.all
    end

    private

    def check_admin
        unless admin?
            redirect_to root_path, alert: 'You are not authorized to access this page.'
        end
    end
end
