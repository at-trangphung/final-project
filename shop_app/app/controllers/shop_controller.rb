class ShopController < BaseController
  before_action :logged_in?
  before_action :current_order
  def index
    @categories = Category.all.where(parent_id: 0)
    @productList = Product.all.paginate page: params[:page],
            per_page: 9
    @order_details = []
    @count_products = 0
    @total = 0
  end

  def create
    
  end

private
  def order_item_params
    params.require(:product).permit(:product_id)
  end

  def search
    @categories = Category.all.where(parent_id: 0)
    @listProduct = @service_shop.search_product
  end
  
end
