# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < ApplicationController
  
  before_action :require_admin

  def index
    @total_products = Product.count
    @total_users = User.count
  end

  private

  def require_admin
    user = User.find_by(id: session[:user_id])
    redirect_to root_path, alert: "Access denied" unless user&.admin?
  end
end
