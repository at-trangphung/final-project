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
    string = product_params[:image_link].original_filename.split('.')[0]
    @categories = Category.all.where(parent_id: 0)
    @sizes = Size.all
    @types = Type.all
    @product = Product.new (product_params)
    if @product.save
      @product_option =  @product.product_options.new(option_params)
      @product_option.save
      upload_images
      @product.update!(image_link: string)
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
    string = product_params[:image_link].original_filename.split('.')[0]
    if product.update(product_params) && product_option.update(option_params)
      upload_images
      @product.update!(image_link: string)
      flash[:success] = "update successfully"
      redirect_to products_path
    else
      flash[:danger] = "update failed"
      @categories = Category.all.where(parent_id: 0)
      @sizes = Size.all
      @types = Type.all
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
    @product = Product.includes(:category).find(params[:id])
  end

  def product_option
    return @option if @option
    @option = ProductOption.find(params[:id])
  end

  def product_params
     params.require(:product).permit(:name, :description,
                                      :category_id, :image_link, :discount,
                                      :view)
  end

  def option_params
     params.require(:product).permit(:size_id, :type_id, :price)
  end

  def upload_images
    @uploads = {}

    @uploads[:image_product] = Cloudinary::Uploader.upload(
      product_params[:image_link], 
      :public_id => product_params[:image_link].original_filename.split('.')[0])
  end
  
end

