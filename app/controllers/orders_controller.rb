class OrdersController < ApplicationController
 

  def index
    @orders = current_user.orders
                          .includes(:order_items, :province)
                          .order(created_at: :desc)
                          .page(params[:page]) # Optional pagination
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
