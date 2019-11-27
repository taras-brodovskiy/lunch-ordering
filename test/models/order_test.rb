require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  def setup
    @order = orders(:one)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "user id should be present" do
    @order.user_id = nil
    assert_not @order.valid?
  end
  
  test "price should be present" do
    @order.price = nil
    assert_not @order.valid?
  end
end
