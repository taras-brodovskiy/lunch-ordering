module OrdersHelper
  def add_item_to_current_order(item)
    kind = item.kind    
    case kind
    when 'first'
      cookies[:first_course] = {
        value: item.name,
        expires: 10.minutes
      }
    when 'main'
      cookies[:main_course] = {
        value: item.name,
        expires: 10.minutes
      }
    when 'drink'
      cookies[:drink] = {
        value: item.name,
        expires: 10.minutes
      }
    end
  end

  def current_order_item_name(kind)        
    case kind
    when 'first'
      item_name = cookies[:first_course]
    when 'main'
      item_name = cookies[:main_course]
    when 'drink'
      item_name = cookies[:drink]
    end
    return item_name
  end

  def current_order_item_price(kind)            
    case kind
    when 'first'
      item_name = cookies[:first_course] 
    when 'main'
      item_name = cookies[:main_course]
    when 'drink'
      item_name = cookies[:drink]
    end
    unless item_name
      return nil
    end
    item = Item.find_by(name: item_name)
    item.price
  end

  def clear_current_order
    if cookies[:first_course]
      cookies.delete :first_course
    end
    if cookies[:main_course]
      cookies.delete :main_course
    end
    if cookies[:drink]
      cookies.delete :drink
    end
  end

  def current_order_total_price
    names = [cookies[:first_course], cookies[:main_course], 
              cookies[:drink]]
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
    if current_user.admin? || current_user.supplier?
      all_orders
    else
      current_user_orders
    end
  end

  def orders_for_json
    out = {}
    n = 1
    @orders.each do |order|
      ns = n.to_s      
      out[ns] = { "User" => order.user.name, 
                  "Email" => order.user.email,
                  "Price" => order.price,
                  "First course" => { "Name" => order.first_course.name,
                                      "Price" => order.first_course.price },
                  "Main course"  => { "Name" => order.main_course.name,
                                      "Price" => order.main_course.price },
                  "Drink"        => { "Name" => order.drink.name,
                                      "Price" => order.drink.price }
      }
      n += 1
    end
    out
  end
end
