class User::CustomersController < BaseController
  layout 'customer'
  before_action :logged_in?
  before_action :find_order, only: %i[show]
 
  def index
    if @service_user.current_user
      id = Customer.find_by(user_id: @service_user.current_user.id)
      @orders = Transaction.where(customer_id: id).order(created_at: :desc)
    end
  end

  def show
    id = Customer.find_by(user_id: @service_user.current_user.id)
    @orders = Transaction.where(customer_id: id).order(created_at: :desc)
    @order_details = @order.orders
  end

  private
    def get_customer
      @customer = User.find_by(id: params[:id])
    end

    def find_order
      @order = Transaction.find_by(id: params[:id])
    end
end
