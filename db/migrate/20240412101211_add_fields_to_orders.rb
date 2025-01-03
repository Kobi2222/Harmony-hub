class AddFieldsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :shipping_address, :string
    add_column :orders, :billing_address, :string
    add_column :orders, :payment_method, :string
  end
end
