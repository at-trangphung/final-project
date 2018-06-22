class Shop::CommentsProductController <  BaseController
  def new
    @comment = Comment.new
  end

  def create
    @service_comment_product.create
    product = @service_comment_product.find_product
    redirect_to product_path(product)
  end

  def destroy
    @service_comment_product.destroy
    product = @service_comment_product.find_product
    redirect_to product_path(product)
  end
end
