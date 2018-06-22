class CheckoutMailer < ApplicationMailer
  def check_order(transaction)
    @transaction = transaction
    @customer = Customer.find(transaction.customer_id).email
    mail to: @customer, subject: "Order"
  end
end
