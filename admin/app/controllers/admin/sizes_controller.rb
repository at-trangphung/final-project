class Admin::SizesController < AdminController
  def index
    @sizes = @service_size.load_list_size
  end

  def new
    @size = Size.new
  end

  def create
    @service_size.create_size
    redirect_to sizes_path
  end

  def edit
    @sizes = @service_size.load_list_size
    @size  = @service_size.find_size
  end

  def update
    @service_size.update_size
    redirect_to sizes_path
  end

  def destroy
    @service_size.destroy_size 
    redirect_to sizes_path
  end  
end
