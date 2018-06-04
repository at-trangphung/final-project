class CategoryController < ApplicationController
 # protect_from_forgery with: :exception
 def index
   @categories = Category.all.where(parent_id: 0)
   @category_child = Category.where(parent_id: params[:parent_id])
 end

  def new
    @category = Category.new
  end

 private
   def category_params
     params.require(:category).permit(:name, :parent_id)
   end
end

