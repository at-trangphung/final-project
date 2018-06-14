class Admin::ProductsController < AdminController
def index
    @productList = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all.where(parent_id: 0)
  end

  def create
    @categories = Category.all.where(parent_id: 0)
    @product = Product.new product_params
    if @product.save
      flash[:success] = "add successfully"
      redirect_to products_path
    else
      flash[:danger] = "add failed"
      render :new
    end
  end

  def edit
    @categories = Category.all.where(parent_id: 0)
    product
  end

  def update
    if product.update(product_params)
      flash[:success] = "update successfully"
      redirect_to products_path
    else
      flash[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    if product.destroy!
      flash[:success] = "deleted successfully"
    else
      flash[:danger] = "deleted failed"
    end
    redirect_to products_path
  end

  private

  def product
    return @product if @product
    @product = Product.find(params[:id])
  end

  def product_params
     params.require(:product).permit(:name, :description, :price,
                                        :category_id, :image_link)
  end
end

