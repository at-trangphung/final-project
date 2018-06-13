class ThanksForOrderController < BaseController
  layout 'customer'

  def index
    if session[:transaction_id]
      @order_items = Order.where(transaction_id: session[:transaction_id])
    end

    @total_price = Transaction.find_by(id: session[:transaction_id]).amount
  end
end
