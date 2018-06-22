class CommentsProductController <  BaseController
  def new
    @comment = Comment.new
  end

  def create
   @product = Product.find(params[:product_id])
    if comment_params[:content].blank?
      flash[:danger] = "add comment failed"
    else
      @comment = @product.comment_products.create!(comment_params)
    end
    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:product_id])
      @comments = []
      @comments << @product.comment_products.find(params[:id])
      @comments << @product.comment_products.find_by(parent_id: params[:id])
      @comments.each do |comment|
        if comment != nil
          comment.destroy
        end  
      end  

    redirect_to product_path(@product)
  end

  private

  def comment_params
    params.require(:comment_product).permit(:content, :parent_id).merge(
                    user_id: @service_user.current_user.id)
  end
end
