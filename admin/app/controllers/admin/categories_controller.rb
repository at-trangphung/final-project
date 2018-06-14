class Admin::CategoriesController < AdminController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "add successfully"
      redirect_to categories_path
    else
      flash[:danger] = "add failed"
      render :new
    end
  end

  def edit
    category
  end

  def update
    if category.update(category_params)
      flash[:success] = "update successfully"
      redirect_to categories_path
    else
      flash[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    if category.destroy!
      flash[:success] = "deleted successfully"
    else
      flash[:danger] = "deleted failed"
    end
    redirect_to categories_path
  end

  private

  def category
    return @category if @category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit :name, :parent_id
  end

end
