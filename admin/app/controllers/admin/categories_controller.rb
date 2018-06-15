  class Admin::CategoriesController < AdminController
    def index
      @categories =
      if params[:search]
        Category.search(params[:search])
      else
        Category.all
      end  
    end

    def new
      @categories = Category.all
      @category = Category.new
    end

    def create
      parent_id = category_params[:parent_id]
      parent_id = 0 if category_params[:parent_id].empty?
      @category = Category.new(name: category_params[:name], parent_id: parent_id)
      if @category.save
        flash[:success] = "add successfully"
        redirect_to categories_path
      else
        @categories = Category.all
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      @categories = Category.all
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

    def search
      debugger
      @category = @service_search.search_category
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
