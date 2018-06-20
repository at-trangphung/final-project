class Transaction < ApplicationRecord
  belongs_to :customer, foreign_key: "customer_id", class_name: "Customer" 
  has_many :orders
  has_many :products, through: :orders
  
end
