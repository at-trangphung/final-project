class ProductsController < BaseController
  layout 'customer'

  def index
    @products = Product.all
  end

  def update
    @product = Product.find(params[:id])
    view = @product.view + 1
    if @product.update_attributes(view: view) 
      flash[:success] = 'Update view successed!'
      redirect_to root_path

    elsif 
      @product.update(product_params)
      flash[:success] = 'Update image_link successed!'
      redirect_to @product
    end
  end

  def show
    @product = Product.find(params[:id])
    @sizes = Product.find_by(id: params[:id]).sizes
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
