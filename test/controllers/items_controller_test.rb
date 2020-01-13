require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    log_in_as(users(:admin))    
    get items_path
    assert_response :success
  end
end
