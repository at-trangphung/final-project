class CartsController < BaseController
  before_action :load_product, only: %i(create)
  before_action :current_order, only: [:show, :edit, :update, :destroy]
  layout 'customer'
  
  def index
    @order_details = []
    @count_products = 0
    @total = 0
    session[:shopping_cart].each do |item|
      @order_details << Order.new(item)
      @count_products += item["quantity"]
      product = Product.find_by id: item["product_id"]
      @total += (item["quantity"] * product.price)
    end
  end

  def show
    
  end

  def create
    order_detail = Order.new item_params
    result = find_product_in_cart(order_detail.product_id)
    if order_detail.quantity.nil? || order_detail.quantity <= 0
      flash[:danger] = "Add to cart failed"
      redirect_to root_path
    elsif result
      check_quantity result, order_detail.quantity
    else
      session[:shopping_cart] << order_detail
      flash[:success] = "Add to cart success"
      redirect_to root_path
    end

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
      if quantity > product.quantity
      flash[:danger] = "Invalid quantity of product"
      else
        result = find_product_in_cart(product.id)
        result["quantity"] = result["quantity"] + 1
      end

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
    params.permit :product_id, :quantity
  end

  def load_product
    current_order
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = "Not found product"
    redirect_to root_path
  end
  
  def find_product_in_cart product_id
    result = nil
    session[:shopping_cart].each do |item|
      next unless item["product_id"] == product_id
      result = item
    end
    result
  end

  def check_quantity result, quantity
    if result["quantity"] + quantity > @product.quantity
      flash[:danger] = "invalid quantity"
      redirect_to root_path
    else
      result["quantity"] += quantity
      flash[:success] = "add success"
      redirect_to root_path
    end
  end
end
