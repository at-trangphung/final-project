  class Admin::SizesController < AdminController
    def index
      @sizes = Size.all
    end

    def new
      @size = Size.new
    end

    def create
      @size = Size.new size_params
      if @size.save
        flash[:success] = "add successfully"
        redirect_to sizes_path
      else
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      @sizes = Size.all
      size
    end

    def update
      if size.update(size_params)
        flash[:success] = "update successfully"
        redirect_to sizes_path
      else
        flash[:danger] = "update failed"
        render :edit
      end
    end

    def destroy
      if size.destroy!
        flash[:success] = "deleted successfully"
      else
        flash[:danger] = "deleted failed"
      end
      redirect_to sizes_path
    end

    private

    def size
      return @size if @size
      @size = Size.find(params[:id])
    end

    def size_params
      params.require(:size).permit :name
    end

  end
