class Admin::OrderDetailsController < AdminController
  before_action :find_order, only: :index

  def index
    @order_details = @order.orders
  end

  private

    def find_order
      @order = Transaction.find_by id: params[:order_id]
      return if @order
    end

end
