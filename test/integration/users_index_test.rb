require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = users(:admin)
    @non_admin = users(:ivan)
  end

  test "index as admin including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'div', text: user.name
      assert_select 'div', text: user.email
    end
  end

  test "index as non-admin" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to signin_url
    log_in_as(@non_admin)
    get users_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
