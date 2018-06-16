class Admin::ProductsController < AdminController
  def index
    @productList = Product.all
  end

  def new
    @product = Product.new
    @product_option = ProductOption.new
    @categories = Category.all.where(parent_id: 0)
    @sizes = Size.all
    @types = Type.all
  end

  def create
    @categories = Category.all.where(parent_id: 0)
    @sizes = Size.all
    @types = Type.all
    @product = Product.new (product_params)
    if @product.save
      @product_option =  @product.product_options.new(option_params)
      @product_option.save
      flash[:success] = "add successfully"
      redirect_to products_path
    else
      flash[:danger] = "add failed"
      render :new
    end
  end

  def edit
    @categories = Category.all.where(parent_id: 0)
    @sizes = Size.all
    @types = Type.all
    product
    product_option
  end

  def update
    if product.update(product_params) && product_option.update(option_params)
      flash[:success] = "update successfully"
      redirect_to products_path
    else
      flash[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    if product.destroy! &&  product.product_options.destroy_all
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

  def product_option
    return @option if @option
    @option = ProductOption.find(params[:id])
  end

  def product_params
     params.require(:product).permit(:name, :description, :price,
                                      :category_id, :image_link, :discount,
                                      :view)
  end
  def option_params
     params.require(:product).permit(:size_id, :type_id)
  end
  
end

