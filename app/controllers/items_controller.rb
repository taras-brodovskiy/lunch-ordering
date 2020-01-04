class ItemsController < ApplicationController
  before_action :access_check
   
  def index
    @item = Item.new
    @kind = params[:kind] || 'first'
    #@items = Item.where("kind = ?", @kind).paginate(page: params[:page])
    @items = Item.where("kind = ?", @kind)
    respond_to do |format|
      format.html { render 'index' }
      format.js
    end
  end

  def create
    @item = Item.new(item_params) 
    if @item.save
      flash[:success] = "The item was successfully added to the list"
      redirect_to items_path
    else
      redirect_to items_path
    end
  end

  private

    def item_params
      params.require(:item).permit(:kind, :name, :price, :photo)
    end
end
