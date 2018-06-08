class BaseController < ApplicationController
  protect_from_forgery with: :exception
  attr_reader :service_user, :service_shop

  # include Services
  include ViewHelper

  before_action :get_service

  def get_service
    @service_user = UserServices.new(session, cookies, params)
    @service_shop = ShopServices.new(params)
  end

  def logged_in?
    @service_user.current_user.present?
  end

end
