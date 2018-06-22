class ProductsController < BaseController
  layout 'customer'

  def index
    @products = Product.all
  end

  def update
  end

  def show
    @product = load_product
    @category = Category.find_by(id: @product.category_id)
    @price = @product.product_options.distinct
    @sizes = @product.sizes.distinct
    @types = @product.types.distinct
    @comment = Comment.new
    @comments = @product.comment_products.where(
          parent_id: 0).paginate page: params[:page], per_page: 7
  end

  private
    def load_product
      Product.find_by(id: params[:id])
    end
end
