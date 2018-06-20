class ProductsController < BaseController
  layout 'customer'


  def index
    @products = Product.all
  end

  def update
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find_by(id: @product.category_id)
    @price = @product.product_options
    @sizes = Product.find_by(id: params[:id]).sizes.distinct
    @types = Product.find_by(id: params[:id]).types.distinct
  end

  private
    def product_params
      params.require(:product).permit(:image_link)
    end

    def permit_params
      params.require(:product).permit(:size, :type)
    end
end
