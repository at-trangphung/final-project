class ShopController < BaseController
  before_action :logged_in?
  def index
    @categories = Category.all.where(parent_id: 0)
    @productList = Product.all.paginate page: params[:page],
            per_page: 9
  end

  private
end
