class ItemsController < ApplicationController
  include ItemsHelper  

  before_action :access_check
   
  def index
    @item = Item.new
    if params[:item]
      @kind = params[:item][:kind]     
    else 
      @kind = 'first'
    end
    @items = Item.where("kind = ?", @kind).paginate(page: params[:page])
  end

  def create
    @item = Item.new(item_params) 
    if @item.save
      flash.now[:info] = "The item was successfully added to the list"
      redirect_to items_path
    else
      @items = Item.where("kind = ?", "first").paginate(page: params[:page])
      render 'items/index'
    end
  end

  private

    def item_params
      params.require(:item).permit(:kind, :name, :price, :photo)
    end
end
