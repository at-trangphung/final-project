  class Admin::TypesController < AdminController
    def index
      @types = Type.all
    end

    def new
      @type = Type.new
    end

    def create
      @type = Type.new type_params
      if @type.save
        flash[:success] = "add successfully"
        redirect_to types_path
      else
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      @types = Type.all
      type
    end

    def update
      if type.update(type_params)
        flash[:success] = "update successfully"
        redirect_to types_path
      else
        flash[:danger] = "update failed"
        render :edit
      end
    end

    def destroy
      if type.destroy!
        flash[:success] = "deleted successfully"
      else
        flash[:danger] = "deleted failed"
      end
      redirect_to types_path
    end

    private

    def type
      return @type if @type
      @type = Type.find(params[:id])
    end

    def type_params
      params.require(:type).permit :name
    end

  end
