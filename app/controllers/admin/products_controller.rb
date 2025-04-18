class Admin::ProductsController < ApplicationController
    
    before_action :require_admin
    before_action :set_product, only: %i[edit update destroy]
    
    def new
        @product = Product.new
        @categories = Category.all
      end
      
      def edit
        @categories = Category.all
      end

    def index
      @products = Product.all
    end

    def show
        redirect_to admin_products_path, alert: "Not available"
      end
  
   
  
    def create
        @product = Product.new(product_params)
        if @product.save
          redirect_to admin_products_path, notice: "Product created successfully"
        else
          puts @product.errors.full_messages # debug line
          @categories = Category.all
          render :new
        end
      end
      
      def update
        if @product.update(product_params)
          redirect_to admin_products_path, notice: "Product updated successfully"
        else
          puts @product.errors.full_messages # debug line
          @categories = Category.all
          render :edit
        end
      end

  
    

    def destroy
        @product.destroy
        redirect_to admin_products_path, notice: "Product deleted!"
      end

      
  
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
        params.require(:product).permit(
    :title,
    :price,
    :description,
    :stock,
    :image,
    :on_sale,
    :category_id
  )

    end
  
    def require_admin
      user = User.find_by(id: session[:user_id])
      redirect_to root_path, alert: "Access denied" unless user&.admin?
    end
  end
  