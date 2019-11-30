class UsersController < ApplicationController

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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Account edited"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
    end
end
