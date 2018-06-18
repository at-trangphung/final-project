class CartsController < BaseController
  # before_action :current_order, only: [:show, :edit, :update, :destroy, :create]
  layout 'customer'

  def index
  end

  def create
    # session[:shopping_cart] ||= []
    # order_detail = Order.new(@service_cart.item_params)
    # price = Product.find(params.require(:cart)[:product_id])
    #                .sizes.find_by(name: params.require(:cart)[:size])
    #                .product_options.map{ |a| a.price }
    # order_detail.price = price[0]
    # order_detail.size = params.require(:cart)[:size]
    # order_detail.type = params.require(:cart)[:type]

    # result = @service_cart.find_product_in_cart(order_detail.product_id , order_detail.size)
    # if result
    #   @service_cart.update_quantity result, order_detail.quantity
    # else
    #   session[:shopping_cart] << order_detail
    #   flash[:success] = "Add to cart success"
    # end
    @service_cart.create
    flash[:success] = "Add to cart success"
    redirect_to request.referrer
  end

  def update
    @service_cart.update
    flash[:success] = "add success"
    # product = Product.find_by id: params[:id]
    # size = product.sizes.find_by(name: params.require(:cart)[:size]).name
    # cart_item_quantity = @service_cart.find_product_in_cart(product.id, size)["quantity"]
    # if params[:button] == "-"
    #   quantity = cart_item_quantity - 1
    #   if quantity <= 0
    #   flash[:danger] = "At least 1 product"
    #   else
    #     result = @service_cart.find_product_in_cart(product.id, size)
    #     result["quantity"] = result["quantity"] - 1
    #   end
    # else 
    #   quantity = cart_item_quantity + 1
    #   result = @service_cart.find_product_in_cart(product.id, size)
    #   result["quantity"] = result["quantity"] + 1
    # end

    redirect_to carts_path
  end

  def destroy
    @service_cart.destroy
    # session[:shopping_cart].each do |item|
    #   session[:shopping_cart].delete(item) if item["product_id"] == params[:id].to_i && 
    #                                           item["size"] == params[:size]
    # end
    flash[:success] = "Delete success"
    redirect_to carts_path
  end
end
