class MenusController < ApplicationController
  include MenusHelper

  before_action :access_check, only: [:new, :create]
  before_action :logged_in_user, only: [:show]

  def show
    if pmenu = params[:menu]
      @menu = Menu.find_by(menu_date: pmenu[:menu_date])
      unless @menu
        @menu = Menu.last
        flash[:info] = "There is no menu for this date. The last existing menu is loaded."
        redirect_to @menu
        return
      end
    else
      @menu = Menu.find_by(id: params[:id])
    end
    
    if params[:item]
      kind = params[:item][:kind]
    else
      kind = 'first'
    end

    @items = @menu.items.where("kind = ?", kind).paginate(page: params[:page])
    @order = Order.new
    store_location
  end

  def new
    if params[:item]
      kind = params[:item][:kind]
    else
      kind = 'first'
    end
    @menu = Menu.today_menu
    @items = Item.where("kind=?", kind).paginate(page: params[:page])
    store_location
  end

  def add_to_current_menu
    item = Item.find_by(name: params[:item_name])
    Menu.add_item_to_today_menu(item)
    redirect_back_or(new_menu_path)
  end
end
