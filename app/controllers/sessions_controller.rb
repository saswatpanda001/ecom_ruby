# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect_to_route_for(user)
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

  private

  def redirect_to_route_for(user)
    if user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to products_path
    end
  end
end
