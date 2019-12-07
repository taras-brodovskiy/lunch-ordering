class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    if !current_user.nil?  
      if current_user.admin?
        @users = User.all.paginate(page: params[:page])
      else
        flash[:danger] = "Users index available for admins only"
        redirect_to root_path    
      end
    else
      flash[:danger] = "You are not signed in"
      redirect_to root_path    
    end
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
      redirect_to(root_url) unless current_user?(@user)
    end
end
