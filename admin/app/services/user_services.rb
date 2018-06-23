class UserServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def create
   @user = User.new user_params
    if @user.save
      flash[:success] = "add successfully"
    end  
  end

  def update
    @user =find_user
    if user.update(user_params)
      flash[:success] = "update successfully"
    end  
  end

  def destroy
     @user =find_user
    if user.destroy!
      flash[:success] = "deleted successfully"
    end  
  end

  
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address, :phone, :avatar)
    end


  def load_list_user
    @users =
      if params[:search]
        User.search(params[:search]).paginate(page: params[:page], per_page: 5)
      else
        User.all.paginate(page: params[:page], per_page: 5)
      end 
  end
end
