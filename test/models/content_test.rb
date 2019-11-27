require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  
  def setup
    @content = contents(:one)
  end

  test "should be valid" do
    assert @content.valid?
  end

  test "should require an order id" do
    @content.order_id = nil
    assert_not @content.valid?
  end

  test "should require a first course id" do
    @content.first_course_id = nil
    assert_not @content.valid?
  end

  test "should require a main course id" do
    @content.main_course_id = nil
    assert_not @content.valid?
  end

  test "should require a drink id" do
    @content.drink_id = nil
    assert_not @content.valid?
  end
end
