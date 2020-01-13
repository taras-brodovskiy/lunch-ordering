require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  
  def setup
    @menu = menus(:one)
  end

  test "should be valid" do
    assert @menu.valid?
  end
end
