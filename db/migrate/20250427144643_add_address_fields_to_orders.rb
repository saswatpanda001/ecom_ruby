class AddAddressFieldsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :payment_method, :string
  end
end
