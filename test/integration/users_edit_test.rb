require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
   
  def setup
    @user = users(:admin)
    @other_user = users(:ivan)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "mail@invalid",
                                              password:              "123",
                                              password_confirmation: "456" } }

    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Adminy"
    email = "adminy@seed.ru"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to root_url
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to signin_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to signin_path
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not flash.empty?
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    get edit_user_path(@other_user)
    assert_nil session[:forwarding_url]
    assert_redirected_to root_url 
    name  = "Adminy"
    email = "adminy@seed.ru"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
