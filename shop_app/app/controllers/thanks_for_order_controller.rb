class ThanksForOrderController < BaseController
  layout 'customer'

  def index
    if session[:transaction_id]
      @order_items = Order.where(transaction_id: session[:transaction_id])
      @transaction = Transaction.find_by(id: session[:transaction_id])
      @customer = Customer.find_by(id: @transaction.customer_id)
      if session[:receiver]
        @receiver = session[:receiver]
        session[:receiver] = nil
      end
      @total_price = @transaction.amount
    end
  end
end
