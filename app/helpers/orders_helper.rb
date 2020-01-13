module OrdersHelper
  def add_item_to_current_order(item)
    kind = item.kind    
    case kind
    when 'first'
      cookies.permanent[:first_course] = {
        value: item.name,
        expires: 10.minutes
      }
    when 'main'
      cookies.permanent[:main_course] = {
        value: item.name,
        expires: 10.minutes
      }
    when 'drink'
      cookies.permanent[:drink] = {
        value: item.name,
        expires: 10.minutes
      }
    end
  end

  def current_order_item_name(kind)        
    case kind
    when 'first'
      item_name = cookies.permanent[:first_course] 
    when 'main'
      item_name = cookies.permanent[:main_course]
    when 'drink'
      item_name = cookies.permanent[:drink]
    end
    return item_name
  end

  def current_order_item_price(kind)            
    case kind
    when 'first'
      item_name = cookies.permanent[:first_course] 
    when 'main'
      item_name = cookies.permanent[:main_course]
    when 'drink'
      item_name = cookies.permanent[:drink]
    end
    unless item_name
      return nil
    end
    item = Item.find_by(name: item_name)
    item.price
  end

  def clear_current_order
    if cookies.permanent[:first_course]
      cookies.delete :first_course
    end
    if cookies.permanent[:main_course]
      cookies.delete :main_course
    end
    if cookies.permanent[:drink]
      cookies.delete :drink
    end
  end

  def current_order_total_price
    names = [cookies.permanent[:first_course], cookies.permanent[:main_course], 
              cookies.permanent[:drink]]
    prices = []
    names.each do |name|
      if name
        prices << Item.find_by(name: name).price
      end
    end
    total_price = BigDecimal("0")  
    prices.each do |price|
      total_price += price
    end
    total_price.to_s
  end

  def clear_order_link
    '/orders/clear-order'
  end

  def last_order_date
    if current_user.admin?
      orders = Order.last 
    else
      orders = current_user.orders.last
    end
    unless orders
      return nil
    end
    orders.order_date
  end

  def current_user_orders
    current_user.orders.where("order_date=?", @orders_date)
  end

  def all_orders
    Order.where("order_date=?", @orders_date)
  end

  def total_price_for_date
    total_price = BigDecimal.new("0")    
    orders = all_orders    
    orders.each { |ord| total_price += ord.price }
    total_price
  end

  def find_orders
    if current_user.admin?
      all_orders
    else
      current_user_orders
    end
  end
end
