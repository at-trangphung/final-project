class ProductsController < ApplicationController
  layout 'account'

  def show
    @product = Product.find(params[:id])
  end
end
