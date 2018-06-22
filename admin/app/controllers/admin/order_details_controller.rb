class Admin::OrderDetailsController < AdminController
  def index
    @order         = @service_order.find_order
    @order_details = @order.orders
  end
end
