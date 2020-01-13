module ItemsHelper
  def items_counter(kind = "first")  
    Item.where("kind=?", kind).count
  end

  def order_item_link(item_name)
    '/orders/to-current-order/' + item_name
  end

  def menu_item_link(item_name)
    '/menus/to-current-menu/' + item_name
  end
end
