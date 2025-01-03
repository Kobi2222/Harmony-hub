class CartsController < ApplicationController
    def show
        @cart = session[:cart] ||= {}
        @products = Product.where(id: @cart.keys)
    end

    def add_to_cart
        product = Product.find(params[:id])
        session[:cart] ||= {}
        session[:cart][product.id.to_s] ||= 0
        session[:cart][product.id.to_s] += 1
        redirect_to cart_path, notice: 'Product added to cart.'
    end

    def remove_from_cart
        session[:cart].delete(params[:id])
        redirect_to cart_path, notice: 'Product removed from cart.'
    end

    def update_quantity
        product_id = params[:id]
        quantity = params[:quantity].to_i
        if quantity > 0
            session[:cart][product_id] = quantity
            notice = 'Quantity updated.'
        else
            session[:cart].delete(product_id)
            notice = 'Product removed from cart.'
        end
        redirect_to cart_path, notice: notice
    end
end
