class Admin::OrdersController < AdminController
  def index
    @orders = @service_order.load_list_order
  end

  def update
    @service_order.update_order
    redirect_to orders_path
  end
end
