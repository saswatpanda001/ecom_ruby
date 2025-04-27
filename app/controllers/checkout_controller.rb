# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
    
    before_action :load_cart_items
    
    def new
      @order = current_user.orders.build
      @provinces = Province.all
      calculate_totals
    end
    
    def create
      @order = current_user.orders.build(order_params)
      @order.status = :pending
      @order.province = current_user.province
      
      if build_order_items && @order.save
        clear_cart
        redirect_to order_path(@order), notice: 'Order placed successfully!'
      else
        @provinces = Province.all
        calculate_totals
        flash.now[:alert] = 'Failed to place order. Please check your information.'
        render :new
      end
    end
    
    private
    
    def load_cart_items
      @cart_items = session[:cart] || {}
      @products = Product.where(id: @cart_items.keys)
      
      if @products.empty?
        redirect_to cart_path, alert: 'Your cart is empty'
      end
    end
    
    def calculate_totals
        @subtotal = @products.sum { |p| p.price * @cart_items[p.id.to_s].to_i }
        
        province = current_user.province || Province.first # fallback if no province
        @gst_amount = (@subtotal * (province.gst || 0) / 100)
        @pst_amount = (@subtotal * (province.pst || 0) / 100)
        @hst_amount = (@subtotal * (province.hst || 0) / 100)
        
        @total = @subtotal + @gst_amount + @pst_amount + @hst_amount
      end
    
    def build_order_items
      @products.each do |product|
        quantity = @cart_items[product.id.to_s].to_i
        @order.order_items.build(
          product: product,
          quantity: quantity,
          product_price: product.price
        )
      end
      
      @order.total_price = @total
      true
    end
    
    def clear_cart
      session[:cart] = {}
    end
    
    def order_params
      params.require(:order).permit(
        :address,
        :city,
        :postal_code,
        :payment_method
      )
    end
  end