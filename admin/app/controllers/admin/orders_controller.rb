class Admin::OrdersController < AdminController
  before_action :find_order, only: :update

  def index
    @orders = Transaction.all
  end

  def update
    status = params[:status].to_i
    if (check_status status) && (@order.update_attribute :status, status)
      @order.send_check_order_email
      flash[:success] =  "update_success"
    else
      flash[:danger] =  "update_failed"
    end
    redirect_to orders_path
  end

  private

  def find_order
    @order = Transaction.find_by id: params[:id]
    return if @order
  end

  def check_status status
    array = [1,2]
    true if array.include? status
  end
end
