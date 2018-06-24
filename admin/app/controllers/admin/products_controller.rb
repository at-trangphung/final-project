class Admin::ProductsController < AdminController
  before_action :load_service
  
  def index
    @productList = @service_product.load_list_product
  end

  def new
    @service_product.init
  end

  def create
    @service_product.create
    redirect_to products_path
    
  end

  def edit
    @categories = Category.where(parent_id: 0)
    @sizes      = Size.all
    @types      = Type.all
    @product    = Product.includes(:category).find_by(id: params[:id])
    @service_product.edit
  end

  def update
    @service_product.update
    redirect_to products_path

  end

  def destroy
    @service_product.destroy    
    redirect_to products_path
  end

  private
  def load_service
    @service_product = ProductServices.new(params, flash)
  end

end
