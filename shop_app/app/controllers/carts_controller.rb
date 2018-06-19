class CartsController < BaseController
  # before_action :current_order, only: [:show, :edit, :update, :destroy, :create]
  layout 'customer'

  def index
  end

  def create
    @service_cart.create
    flash[:success] = "Add to cart success"
    redirect_to request.referrer
  end

  def update
    @service_cart.update
    flash[:success] = "add success"
    redirect_to carts_path
  end

  def destroy
    @service_cart.destroy
    flash[:success] = "Delete success"
    redirect_to carts_path
  end
end
