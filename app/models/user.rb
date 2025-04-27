class User < ApplicationRecord
    has_secure_password
  
    # Associations
    belongs_to :province, optional: true
    has_many :orders, foreign_key: 'user_id', dependent: :destroy
    has_many :cart_items, dependent: :destroy
  
    # Validations
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
    validates :province_id, presence: true
  end