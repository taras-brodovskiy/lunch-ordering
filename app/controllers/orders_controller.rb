class OrdersController < ApplicationController
  include OrdersHelper
    
  before_action :logged_in_user

  def show
    if porder = params[:order]
      @order = Order.find_by(order_date: porder[:order_date])
      unless @order
        @order = Menu.last
        flash[:info] = "There is no menu for this date. The last existing menu is loaded."
        redirect_to @menu
        return      
      end
    else
      @menu = Menu.find_by(id: params[:id])
    end
    @orders = Order.where().paginate(page: params[:page])
    render 'index'
  end

  def create
    @order = current_user.orders.build(order_params)
    
    if Order.find_by(order_date: @order.order_date, user_id: current_user.id)
      flash[:error] = "Already have an order for today"
      redirect_back_or(root_url)
      return
    end

    if @order.save
      flash[:success] = "Order created!"
      clear_current_order
      redirect_to orders_path
    else
      flash[:error] = "Order filled incorrectly"
      redirect_back_or(root_url)
    end
  end

  def add_to_current_order
    item = Item.find_by(name: params[:item_name])
    add_item_to_current_order(item)
    redirect_back_or(Menu.last)
  end

  def clear_order
    clear_current_order
    redirect_back_or(Menu.last)
  end

  def index
    if params[:order]
      @orders_date = params[:order][:order_date]
    else
      @orders_date = last_order_date
    end
    if current_user.supplier?
      if @orders_date
        @orders = find_orders
      else
        @orders = nil
      end
      out = orders_for_json
      render json: out
    end
    unless @orders_date
      flash.now[:info] = "There is no existing orders."
      @orders = nil
      return
    end
    @orders = find_orders.paginate(page: params[:page])
    if @orders.size == 0
      flash.now[:info] = "There is no orders for this date. The last existing orders is loaded."
      @orders_date = last_order_date
      @orders = find_orders.paginate(page: params[:page])
    end
  end

  private
    def order_params
      pars = params.require(:order).permit(:price, :order_date, :first_course, :main_course, :drink)
      pars[:first_course] = Item.find_by(name: pars[:first_course])
      pars[:main_course] = Item.find_by(name: pars[:main_course])
      pars[:drink] = Item.find_by(name: pars[:drink])
      pars
    end
end
