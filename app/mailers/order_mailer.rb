class OrderMailer < ApplicationMailer
    def order_confirmation(order)
        @order = order
        mail(to: @order.user.email, subject: 'Order Confirmation')
    end
end
