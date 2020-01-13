module ItemsHelper
  def items_counter(kind = "first")  
    Item.where("kind=?", kind).count
  end

  def item_link(item_name)
    '/orders/to-current-order/' + item_name
  end
end
