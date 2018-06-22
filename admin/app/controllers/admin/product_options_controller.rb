class Admin::ProductOptionsController < AdminController
  def index
    @product_options = @service_product_option.load_list_product_option
  end

  def new
    @product_option = ProductOption.new
    load_data
  end

  def create
    @service_product_option.create_product_option
    redirect_to product_options_path
  end

  def edit
    load_data
    @product_options = @service_product_option.load_list_product_option
    @product_option  = @service_product_option.find_product_option
    
  end

  def update
    @service_product_option.update_product_option
    redirect_to product_options_path
  end

  def destroy
    @service_product_option.destroy_product_option
    redirect_to product_options_path
  end

  def load_data  
    @sizes = Size.all
    @types = Type.all
    @products = Product.all
  end
end
