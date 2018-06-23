class Transaction < ApplicationRecord
  belongs_to :customer, foreign_key: "customer_id", class_name: "Customer" 
  has_many :orders
  has_many :products, through: :orders
  
  def send_check_order_email
    CheckoutMailer.check_order(self).deliver_now
  end
end
