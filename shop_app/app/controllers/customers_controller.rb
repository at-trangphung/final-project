class CustomersController < BaseController
  layout 'customer'
  before_action :logged_in?
  before_action :find_order, only: %i[show]
 
  def index
    @orders = Transaction.where(customer_id: @service_user.current_user).order(created_at: :desc)
  end

  def show
    @order_details = @order.orders
  end

  private
    def get_customer
      @customer = User.find_by(id: params[:id])
    end

    def find_order
      return if @order
      @order = Transaction.find_by(id: params[:id])
    end

end
