class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def all_orders
        @orders = current_user.is_admin? ? Order.all : []
    end

    def new
        if session[:cart].present?
            @order = Order.new
        else
            redirect_to cart_path, alert: 'Please add items in cart.'
        end
    end

    def show
        @order = Order.find(params[:id])
        @tax_rate = TaxRate.where(order_id: @order.id).last

        unless @tax_rate.present?
            tax_rates = TaxRate.province_tax_rates['Alberta']
            @gst = tax_rates[:gst]
            @pst = tax_rates[:pst]
            @hst = tax_rates[:hst]

            @total_tax = @gst + @pst + @hst

            @tax_rate = TaxRate.create(province: 'Ontario', rate: @total_tax, order_id: @order.id)
        end
        # Ensure that only the user who placed the order can see it
        if current_user.is_admin == false
            unless @order.user == current_user
                redirect_to root_path, alert: 'You are not authorized to view this order.'
            end
        end
    end

    def update_status
        @order = Order.find(params[:id])
        
        # Assuming the new status is passed as a parameter called :status
        new_status = params[:status]

        if @order.update(status: new_status)
            redirect_to order_path(@order), notice: 'Order status updated successfully.'
        else
            redirect_to order_path(@order), alert: 'Failed to update order status.'
        end
    end

    def create
        @order = Order.new(order_params)
        @order.user = current_user
        @cart = session[:cart]
        @order.total_price = calculate_total_price(@cart)
        
        if @order.save
            # Create order items from the cart
            create_order_items(@order, @cart)
            
            # If the user selected 'Stripe' as the payment method
            if order_params[:payment_method] == 'Stripe'
                handle_stripe_payment(@order, params[:order][:payment_method_id])
            else
                # Redirect to the order show page with a success notice
                redirect_to order_path(@order), notice: 'Order successfully placed!'
            end
            
            # Clear the cart after order creation
            OrderMailer.order_confirmation(@order).deliver_later
            session[:cart] = nil
        else
            # Handle order creation failure (e.g., render the new order form again)
            render :new
        end
    end

    def handle_stripe_payment(order, payment_method_id)
        Stripe.api_key = 'sk_test_51P5M0iFDcZUJTZvIyXy6KjRSa6jcvkeZd3DqkU0kit5EecfA9ilckvp7wakMO4Ra0ufm7Dqy8a2XUx82XoCEAzga00S6Aq7ZKg' # Replace with your Stripe secret key
    
        # Create a PaymentIntent
        payment_intent = Stripe::PaymentIntent.create({
            amount: (order.total_price * 100).to_i, # Convert to cents
            currency: 'usd',
            payment_method: payment_method_id,
            confirm: true,
            # Set automatic_payment_methods[enabled] to true to avoid redirect-based payment methods
            automatic_payment_methods: {
                enabled: true
            },
            return_url: root_url
        })
    
        if payment_intent.status == 'succeeded'
            # Payment succeeded
            order.update(status: 'paid')
            render json: { status: '200', url: order_path(order), message: 'Order and payment have been successfully completed through Stripe.' }
        else
            # Payment failed
            order.update(status: 'failed')
            render json: { status: '500', url: new_order_path, message: 'Payment failed. Please try again.' }
        end
    end

    private

    def order_params
        params.require(:order).permit(:shipping_address, :billing_address, :payment_method)
    end

    def create_order_items(order, cart)
        # Iterate over the cart and create OrderItem objects
        cart.each do |product_id, quantity|
            product = Product.find(product_id)
            order_item = OrderItem.new(
                order: order,
                product: product,
                quantity: quantity,
                price: product.price
            )
            order_item.save
        end
    end

    def calculate_total_price(cart)
        # Calculate the total price of the cart items
        cart.sum do |product_id, quantity|
            product = Product.find(product_id)
            product.price * quantity
        end
    end
end