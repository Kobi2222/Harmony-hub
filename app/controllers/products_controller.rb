# app/controllers/products_controller.rb
class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :products_page]
    
    def index
        @products = Product.all
    end

    def products_page
        @products = Product.all

        if params[:category].present?
          category = Category.find_by(id: params[:category])
          @products = category.products if category
        end

        @products = @products.where("created_at >= ?", Date.today) if params[:new_products].present?
        @products = @products.where("updated_at >= ?", Date.today) if params[:recently_updated].present?

        @products = @products.paginate(page: params[:page], per_page: 10)
    end

    def show
        @product = Product.find(params[:id])
    end
    
    def new
      @product = Product.new
    end
  
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @product = Product.find(params[:id])
    end
  
    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    end
  
    private
  
    def product_params
        params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id, :image)
    end
end