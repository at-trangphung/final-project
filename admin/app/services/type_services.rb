class TypeServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def create
    @type = Type.new type_params
    if @type.save
        flash[:success] = "add successfully"
    end
  end

  def update
    type = find_type
    if type.update(type_params)
      flash[:success] = "update successfully"
    end
  end

  def destroy
    if type.destroy!
      flash[:success] = "deleted successfully"
    end
  end

  def find_type
    return @type if @type
    @type = Type.find_by(id: params[:id])
  end

  def load_list_type
    return @types if @types
    @types = Type.all
  end

  def type_params
    params.require(:type).permit :name
  end
end  
