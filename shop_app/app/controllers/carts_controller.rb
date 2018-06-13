class CartsController < BaseController
  before_action :current_order, only: [:show, :edit, :update, :destroy, :create]
  layout 'customer'

  def index
  end

  def show
  end

  def create
    session[:shopping_cart] ||= []
    order_detail = Order.new(item_params)
    option = params.require(:cart).permit(:size, :type)
    result = find_product_in_cart(order_detail.product_id)
    # if order_detail.quantity.nil? || order_detail.quantity == 0
    #   flash[:danger] = "Add to cart failed"
    #   redirect_to root_path
    # elsif result
    if result
      update_quantity result, order_detail.quantity
    else
      session[:shopping_cart] << order_detail
      flash[:success] = "Add to cart success"
    end
    redirect_to request.referrer
  end

  def update
    product = Product.find_by id: params[:id]
    cart_item_quantity = find_product_in_cart(product.id)["quantity"]
      if params[:button] == "-"
      quantity = cart_item_quantity - 1
      if quantity <= 0
      flash[:danger] = "At least 1 product"
      else
        result = find_product_in_cart(product.id)
        result["quantity"] = result["quantity"] - 1
      end
    else 
      quantity = cart_item_quantity + 1
      result = find_product_in_cart(product.id)
      result["quantity"] = result["quantity"] + 1
    end

    redirect_to carts_path
  end

  def destroy
    session[:shopping_cart].each do |item|
      session[:shopping_cart].delete(item) if item["product_id"] == params[:id].to_i
    end
    flash[:success] = "Delete success"
    redirect_to carts_path
  end

  private

  def item_params
    params.require(:cart).permit(:product_id, :quantity)
  end
  
  def find_product_in_cart(product_id)
    return unless session[:shopping_cart]
    session[:shopping_cart].detect do |item|
      item["product_id"] == product_id
    end
  end

  def update_quantity result, quantity
    result["quantity"] += quantity
    flash[:success] = "add success"
  end
end
