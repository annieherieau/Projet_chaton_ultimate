class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update]
    
    def index
        @items = Item.all
    end

    def show
    end

    def new
        unless admin?
            redirect_to root_path
        end
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
    
        if @item.save
          redirect_to item_path(@item), notice: 'Votre item a été crée avec succès.'
        else
            render :new
        end
    end
      
    def edit
        unless admin?
            redirect_to root_path
        end
    end
      
    def update
        if @item.update(item_params)
            redirect_to @item, notice: 'Item was successfully updated.'
        else
            render :edit
        end
    end
      
        private
      
        def set_item
          @item = Item.find(params[:id])
        end
      
        def item_params
          params.require(:item).permit(:title, :description, :price, :photo) 
        end
end
