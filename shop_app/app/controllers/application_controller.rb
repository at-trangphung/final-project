class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :load_cart

  def current_order
    session[:shopping_cart] ||= []
  end

  def load_cart
    @count_products = 0     
    @order_items = []
    current_order.each do |item|
      @order_items << Order.new(item)
      @count_products += item["quantity"]

    end
    @order_items
  end

end
