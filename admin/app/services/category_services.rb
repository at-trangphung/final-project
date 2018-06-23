class CategoryServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def create_category
    parent_id = category_params[:parent_id]
    parent_id = 0 if category_params[:parent_id].empty?
    @category = Category.new(name: category_params[:name], parent_id: parent_id)
    if @category.save
      flash[:success] = "add successfully"
    end
  end

  def update_category
    category = find_category
    if category.update(category_params)
      flash[:success] = "update successfully"
    end  
  end

  def destroy_category
    category = find_category
    if category.destroy!
      flash[:success] = "deleted successfully"
    end  
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end


  def load_list_category
    @categories =
      if params[:search]
        Category.search(params[:search]).paginate page: params[:page], per_page: 5
      else
        Category.all.paginate page: params[:page], per_page: 5
      end 
  end

  def find_category
    return @category if @category
    @category = Category.find_by(id: params[:id])
  end
end
