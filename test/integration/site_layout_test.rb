require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ivan)
  end
  
  test "layout links for unlogged-in user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signin_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
  end
  
  test "layout links for logged-in user" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", edit_user_path(@user)
  end
end
