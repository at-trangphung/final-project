class ShopController < ApplicationController
  def index
    @categories = Category.all.where(parent_id: 0)
    # @category_child = Category.all.where(parent_id: params[:parent_id]) 
  end
end
