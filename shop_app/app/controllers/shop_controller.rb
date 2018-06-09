class ShopController < BaseController
  before_action :logged_in?
  def index
    @categories = Category.all.where(parent_id: 0)
    @productList = Product.all.paginate page: params[:page], per_page: 9
  end

  def search
    @categories = Category.all.where(parent_id: 0)
    @listProduct = @service_shop.search_product
  end

  def show
    @categories = Category.all.where(parent_id: 0)
    @productByCategory =  Category.all.where(parent_id: params[:id]).paginate page: params[:page], per_page: 9
  end  

  private

end
