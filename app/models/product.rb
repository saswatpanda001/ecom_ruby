class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :category
  # other associations and validations
end
