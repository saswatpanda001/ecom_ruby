class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total_price
      t.string :payment_id
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
