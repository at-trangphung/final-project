class CheckoutController < BaseController
  layout 'customer'

  def create
    @service_checkout.checkout
    redirect_to thanks_for_order_path
  end

  def new
    @transaction = Transaction.new
  end

  def show
    @order_items = Order.where(transaction_id: params[:id])
    @transaction = Transaction.find_by(id: session[:transaction_id])
    @customer = Customer.find_by(id: @transaction.customer_id)
    @total_price = @transaction.amount
  end
end
