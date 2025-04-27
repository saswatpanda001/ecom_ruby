# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :load_provinces, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to_route_for(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def load_provinces
    @provinces = Province.all.order(:name)
  end

  def user_params
    params.require(:user).permit(:email, :password, :username, :province_id)
  end

  def redirect_to_route_for(user)
    if user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to products_path
    end
  end
end