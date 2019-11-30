require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ivan)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should not allow the admin attribute to be edited via the web" do
    patch user_path(@user), params: {
                                    user: { password:              "",
                                            password_confirmation: "",
                                            admin: true } }
    assert_not @user.admin?
  end
end
