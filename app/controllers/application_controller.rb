

class ApplicationController < ActionController::Base
  
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end


  def admin?
    current_user&.admin?
  end

  def require_login
    unless user_signed_in?
      flash[:alert] = "Please log in to continue"
      redirect_to login_path
    end
  end
  


  def require_admin
    unless admin?
      flash[:alert] = "Access denied!"
      redirect_to root_path
    end
  end
end
