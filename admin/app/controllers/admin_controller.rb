class AdminController < ActionController::Base
  layout "admin"
  attr_reader :service_article, :service_category, :service_product, 
              :service_size, :service_type, :service_product_option,
              :service_order, :service_user

  before_action :get_service, :authorize, :logged_in?

  def get_service
    @service_user     = UserServices.new(session, cookies, params, flash)
    @service_article  = ArticleServices.new(params, flash)
    @service_category = CategoryServices.new(params, flash)
    @service_product  = ProductServices.new(params, flash)
    @service_size     = SizeServices.new(params, flash)
    @service_type     = TypeServices.new(params, flash)
    @service_product_option = ProductOptionServices.new(params, flash)
    @service_order    = OrderServices.new(params, flash)
  end

  def logged_in?
    @service_user.current_user.present?
  end

  def authorize
    if cookies[:remember] != 1
      # redirect_to sessions_sign_in_path unless (current_user && unexperied?)
      redirect_to login_path unless (@service_user.current_user)   
    end
  end
end
