class Admin::UsersController < AdminController
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params
      if @user.save
        flash[:success] = "add successfully"
        redirect_to users_path
      else
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      user
    end

    def update
      if user.update(user_params)
        flash[:success] = "update successfully"
        redirect_to users_path
      else
        flash[:danger] = "update failed"
        render :edit
      end
    end

    def destroy
      if user.destroy!
        flash[:success] = "deleted successfully"
      else
        flash[:danger] = "deleted failed"
      end
      redirect_to users_path
    end

    private

    def user
      return @user if @user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address, :phone, :avatar)
    end

  end
