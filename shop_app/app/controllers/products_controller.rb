class ProductsController < ApplicationController
  layout 'account'

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



  private
    def product_params
      params.require(:product).permit(:image_link)
    end

    def check_view

    end
end
