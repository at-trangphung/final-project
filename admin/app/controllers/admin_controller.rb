class AdminController < ActionController::Base
  layout "admin"
  attr_reader :service_article, :service_category, :service_product, 
              :service_size, :service_type, :service_product_option,
              :service_order

  before_action :get_service
  
  def get_service
    @service_article  = ArticleServices.new(params, flash)
    @service_category = CategoryServices.new(params, flash)
    @service_product  = ProductServices.new(params, flash)
    @service_size     = SizeServices.new(params, flash)
    @service_type     = TypeServices.new(params, flash)
    @service_product_option = ProductOptionServices.new(params, flash)
    @service_order    = OrderServices.new(params, flash)
  end
end
