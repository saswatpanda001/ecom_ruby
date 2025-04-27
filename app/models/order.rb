class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

  # Validations
  validates :user_id, presence: true
  validates :province_id, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  # Status enum - corrected syntax
 

  accepts_nested_attributes_for :order_items
end
