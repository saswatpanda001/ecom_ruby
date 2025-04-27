class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: { greater_than: 0 }
  validates :product_price, numericality: { greater_than_or_equal_to: 0 }
  
  before_save :set_product_price
  
  private
  
  def set_product_price
    self.product_price ||= product.price
  end
end
