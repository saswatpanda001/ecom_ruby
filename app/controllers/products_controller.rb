class ProductsController < ApplicationController
  
  def index
    @categories = Category.all
    @products = Product.all

    if params[:on_sale] == "true"
      @products = Product.where(on_sale: true)
    else
      @products = Product.all
    end
    

    # Filter by category
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    @products = @products.where(on_sale: true) if params[:on_sale] == "true"
    

    # Search by keyword
    @products = @products.where("title ILIKE ?", "%#{params[:search]}%") if params[:search].present?

    # Kaminari Pagination (10 per page)
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
  



end
