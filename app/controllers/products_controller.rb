class ProductsController < ApplicationController
  

    def index
      @categories = Category.all
      @products = Product.all
  
      # Apply category filter if parameter exists
      if params[:category_id].present? && params[:category_id] != ""
        @products = @products.where(category_id: params[:category_id])
      end
  
      # Apply status filter
      case params[:status]
      when 'on_sale'
        @products = @products.where(on_sale: true)
      when 'not_on_sale'
        @products = @products.where(on_sale: false)
      when 'new'
        @products = @products.where('created_at > ?', 3.days.ago)
      end
  
      # Apply search filter
      if params[:search].present?
        @products = @products.where("title ILIKE ?", "%#{params[:search]}%")
      end
  
      # Pagination
      @products = @products.page(params[:page]).per(12)
    end


  def show
    @product = Product.find(params[:id])
  end
  



end
