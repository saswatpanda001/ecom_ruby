class AddFinancialColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :subtotal, :decimal, precision: 10, scale: 2
    add_column :orders, :gst_amount, :decimal, precision: 10, scale: 2
    add_column :orders, :pst_amount, :decimal, precision: 10, scale: 2
    add_column :orders, :hst_amount, :decimal, precision: 10, scale: 2
  end
end