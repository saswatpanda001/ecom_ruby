class CreateCategorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :categorizations do |t|
      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    # Ensure the combination of product_id and category_id is unique
    add_index :categorizations, [:product_id, :category_id], unique: true
  end
end