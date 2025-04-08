class CartsController < ApplicationController
  before_action :initialize_cart

  # Display the cart page
  def show
    @cart_items = session[:cart] || {}
    @products = Product.where(id: @cart_items.keys.map(&:to_i))  # Ensure keys are integers
  end

  # Add product to cart
  def add
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = session[:cart][product_id].to_i + quantity
      flash[:notice] = "Product added to cart!"
    else
      flash[:alert] = "Invalid quantity!"
    end

    redirect_to cart_path
  end

  # Update product quantity in cart
  def update
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = quantity
      flash[:notice] = "Cart updated!"
    else
      session[:cart].delete(product_id)  # Remove item if quantity is 0
      flash[:notice] = "Product removed from cart!"
    end

    redirect_to cart_path
  end

  # Remove product from cart
  def remove
    product_id = params[:id].to_s

    if session[:cart].key?(product_id)
      session[:cart].delete(product_id)  # Correctly delete only this product
      flash[:notice] = "Product removed from cart!"
    else
      flash[:alert] = "Product not found in cart!"
    end

    redirect_to cart_path
  end

  private

  # Ensure session cart is initialized
  def initialize_cart
    session[:cart] ||= {}
  end
end
