  class Admin::ProductOptionsController < AdminController
    def index
      @product_options = ProductOption.all
    end

    def new
      @product_option = ProductOption.new
      @sizes = Size.all
      @types = Type.all
      @products = Product.all
    end

    def create
      @sizes = Size.all
      @types = Type.all
      @products = Product.all
      @product_option = ProductOption.new product_option_params
      if find_product_on_list(product_option_params[:product_id], 
        product_option_params[:type_id], 
        product_option_params[:size_id],product_option_params[:price]).nil? 
        @product_option.save
        flash[:success] = "add successfully"
        redirect_to product_options_path
      else
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      @product_options = ProductOption.all
      product_option
      @sizes = Size.all
      @types = Type.all
      @products = Product.all
    end

    def update
      if product_option.update(product_option_params)
        flash[:success] = "update successfully"
        redirect_to product_options_path
      else
        flash[:danger] = "update failed"
        render :edit
      end
    end

    def destroy
      if product_option.destroy!
        flash[:success] = "deleted successfully"
      else
        flash[:danger] = "deleted failed"
      end
      redirect_to product_options_path
    end

    private

    def product_option
      return @product_option if @product_option
      @product_option = ProductOption.find(params[:id])
    end

    def product_option_params
      params.require(:product_option).permit :product_id, :type_id, :size_id, :price
    end

    def find_product_on_list (product_id, type_id, size_id, price)
      return result = ProductOption.find_by(product_id: product_id,
                                      type_id: type_id,
                                      size_id: size_id, price: price.to_s)
    end

  end
