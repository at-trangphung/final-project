class BaseController < ApplicationController
  protect_from_forgery with: :exception
  attr_reader :service_user, :service_shop, :service_checkout, 
              :service_cart, :service_comment, :service_comment_product
  attr_accessor :total
  # include Services
  include ViewHelper

  before_action :get_service
  helper_method :current_order
  before_action :load_cart
  
  def get_service
    @service_user = UserServices.new(session, cookies, params)
    @service_shop = ShopServices.new(params)
    @service_checkout = CheckoutServices.new(params, @service_user.current_user, load_cart, @total, session)
    @service_cart = CartServices.new(params, session)
    @service_comment = CommentServices.new(params, flash, @service_user.current_user)
    @service_comment_product = CommentProductServices.new(params, flash, @service_user.current_user)
  end

  def logged_in?
    @service_user.current_user.present?
  end

  def current_order
    session[:shopping_cart] ||= session[:shopping_cart]
  end

  def load_cart
    @count_products = 0     
    @order_items = []
    return if current_order.nil?
    @total = 0
    current_order.each do |item|
      @count_products += item["quantity"]
      @total += (item["quantity"].to_f * item["price"].to_f)
      item["total_payment"] = (item["quantity"].to_f * item["price"].to_f)
      @order_items << Order.new(item)
    end
    @order_items
  end
end
