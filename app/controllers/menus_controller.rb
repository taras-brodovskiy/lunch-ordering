class MenusController < ApplicationController
  before_action :access_check, only: [:new, :create]
  before_action :logged_in_user, only: [:show]

  def show
    @menu = Menu.find(params[:menu_date])
  end

  #private
  #  def item_params
  #    params.require(:menu).permit(:menu_date)
  #  end
end
