class UsersController < ApplicationController
  before_action :access_check, only: [:index]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      flash[:success] = "You have successfully signed up! Please, log in with your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account edited"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
  
    # Strong parameters
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Access denied"
        redirect_to(root_url)
      end
    end
end
