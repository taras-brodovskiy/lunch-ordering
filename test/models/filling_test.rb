require 'test_helper'

class FillingTest < ActiveSupport::TestCase
  def setup
    @filling = fillings(:one)
  end

  test "should be valid" do
    assert @filling.valid?
  end

  test "should require an menu id" do
    @filling.menu = nil
    assert_not @filling.valid?
  end

  test "should require an item id" do
    @filling.item_id = nil
    assert_not @filling.valid?
  end
end
