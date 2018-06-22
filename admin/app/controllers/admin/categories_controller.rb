class Admin::CategoriesController < AdminController
  def index
    @categories = @service_category.load_list_category
  end

  def new
    @categories = @service_category.load_list_category
    @category   = Category.new
  end

  def create
    @service_category.create_category
    redirect_to categories_path
    
  end

  def edit
    @categories = @service_category.load_list_category
    @category   = @service_category.find_category
  end

  def update
    @service_category.update_category
    redirect_to categories_path
  end

  def destroy
    @service_category.destroy_category
    redirect_to categories_path
  end
end
