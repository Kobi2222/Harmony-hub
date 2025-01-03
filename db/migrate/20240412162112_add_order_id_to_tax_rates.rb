class AddOrderIdToTaxRates < ActiveRecord::Migration[7.1]
  def change
    add_column :tax_rates, :order_id, :integer
  end
end
