require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  
  def setup
    @menu = menus(:one)
  end

  test "should be valid" do
    assert @menu.valid?
  end

  test "menu date should be today on creation, updating, saving" do
    y_day = Time.zone.yesterday
    @menu.menu_date = y_day
    assert_not @menu.valid?
  end
end
