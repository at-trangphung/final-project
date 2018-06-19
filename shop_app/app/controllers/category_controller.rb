class CategoryController < ApplicationController
 # protect_from_forgery with: :exception
  def index
  end

  def new
    @category = Category.new
  end

 private
  def category_params
     params.require(:category).permit(:name, :parent_id)
  end


end
