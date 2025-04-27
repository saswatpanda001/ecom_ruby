class CheckoutController < ApplicationController
   
    before_action :load_cart_items
    before_action :calculate_totals, only: [:new, :create]
    
    def new
      @order = current_user.orders.build
      @provinces = Province.all
    end
    
    def create
      @order = current_user.orders.build(order_params)
      @order.assign_attributes(
        status: :pending,
        province: current_user.province,
        subtotal: @subtotal,
        gst_amount: @gst_amount,
        pst_amount: @pst_amount,
        hst_amount: @hst_amount,
        total_price: @total
      )
  
      if save_order_with_items
        clear_cart
        redirect_to order_path(@order), notice: 'Order placed successfully!'
      else
        @provinces = Province.all
        flash.now[:alert] = order_error_message
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def load_cart_items
      @cart_items = session[:cart] || {}
      @products = Product.where(id: @cart_items.keys)
      
      return unless @products.empty?
      redirect_to cart_path, alert: 'Your cart is empty'
    end
  
    def calculate_totals
      @subtotal = calculate_subtotal
      calculate_taxes
      @total = @subtotal + @gst_amount + @pst_amount + @hst_amount
    end
  
    def calculate_subtotal
      @products.sum { |p| p.price.to_d * @cart_items[p.id.to_s].to_i }
    end
  
    def calculate_taxes
      province = current_user.province || Province.first
      @gst_amount = calculate_tax(@subtotal, province.gst)
      @pst_amount = calculate_tax(@subtotal, province.pst)
      @hst_amount = calculate_tax(@subtotal, province.hst)
    end
  
    def calculate_tax(amount, rate)
      (amount * rate.to_d / 100).round(2)
    end
  
    def save_order_with_items
      ActiveRecord::Base.transaction do
        @order.save && build_order_items
      end
    end
  
    def build_order_items
      @products.each do |product|
        @order.order_items.create(
          product: product,
          quantity: @cart_items[product.id.to_s].to_i,
          product_price: product.price.to_d
        )
      end
    end
  
    def clear_cart
      session.delete(:cart)
    end
  
    def order_error_message
      @order.errors.full_messages.to_sentence.presence || 'Failed to place order. Please check your information.'
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