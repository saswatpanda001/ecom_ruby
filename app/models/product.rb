class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  
  # Add these associations with dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  

end
