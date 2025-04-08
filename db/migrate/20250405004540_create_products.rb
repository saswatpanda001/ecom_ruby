class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.boolean :on_sale
      t.references :category, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
