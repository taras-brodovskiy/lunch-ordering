class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to signin_url
      end
    end

    # Restrict access for non-admin users.
    def access_check
      if !current_user.nil?      
        if !current_user.admin?  
          flash[:danger] = "This page available for admins only"
          redirect_back_or root_path
        end
      else
        redirect_to root_path
      end
    end
end
