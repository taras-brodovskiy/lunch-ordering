class ItemsController < ApplicationController
  before_action :access_check
   
  def index
    @items = Item.all.paginate(page: params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params) 
    if @item.save
      flash[:success] = "The item was successfully added to the list"
      redirect_to items_path
    else
      render 'new'
    end
  end

  private

    def item_params
      params.require(:item).permit(:kind, :name, :price, :photo)
    end
end
