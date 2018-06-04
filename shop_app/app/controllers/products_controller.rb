class ProductsController < ApplicationController
  layout 'account'

  def index
    # @all_product = @service.search
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = 'Update image_link successed!'
      redirect_to @product
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private
    def product_params
      params.require(:product).permit(:image_link)
    end
end
