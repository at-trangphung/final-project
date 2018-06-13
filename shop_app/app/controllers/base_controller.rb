class BaseController < ApplicationController
  protect_from_forgery with: :exception
  attr_reader :service_user, :service_shop

  # include Services
  include ViewHelper

  before_action :get_service
  helper_method :current_order
  before_action :load_cart
  
  def get_service
    @service_user = UserServices.new(session, cookies, params)
    @service_shop = ShopServices.new(params)
  end

  def logged_in?
    @service_user.current_user.present?
  end

  def current_order
    @current_order = session[:shopping_cart] ? session[:shopping_cart] : []
  end

  def load_cart
    @count_products = 0     
    @order_items = []
    return if current_order.nil?
    @total = 0
    current_order.each do |item|
      @count_products += item["quantity"]
      product = Product.find_by(id: item["product_id"])
      @total += (item["quantity"].to_i * product.price.to_i)
      item["total_payment"] = (item["quantity"].to_i * product.price.to_i)
      @order_items << Order.new(item)
    end
    @order_items
  end
end
