class BaseController < ApplicationController
  protect_from_forgery with: :exception
  attr_reader :service_user

  include Services
  include ViewHelper

  before_action :get_service_user

  def get_service_user
    @service_user = ServiceUser.new(session, cookies, params)
  end

  def logged_in?
    @service_user.current_user.present?
  end
end
