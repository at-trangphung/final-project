class UsersController < BaseController
  layout 'account'
  # before_action :get_service_user
  # before_action :init_service
  before_action :logged_in?
  before_action :get_user, only: %i[edit update destroy show]
 
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    sign_up 
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password]
      if params[:user][:password].blank?
        flash[:danger] = 'Update password failed!'
        render 'show' 
      elsif @user.update_attributes(change_password_params)
        flash[:success] = 'Update password successed!'
        redirect_to @user
      else
        flash[:danger] = 'Update password failed!'
        render 'show' 
      end
    else
      if @user.update(permit_params)
        flash[:success] = 'Update profile successed!'
        redirect_to @user
      else
        render 'edit'
      end
    end 
  end
   
  def destroy
    log_out @user
    @user.destroy
    redirect_to root_path  
  end

 # def init_service
 #   @service = UserService.new(params, @current_user)
 # end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    def permit_params
      params.require(:user).permit(:first_name, :last_name, :email, :address, :phone, :avatar)
    end

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def sign_up
      @user = User.new(user_params)
      if @user.save
        # UserMailerPreview.account_activation(@user).deliver_now
        @user.send_activation_email
        message  = "Created account. "
        message += "Please check your email to activate your account."
        flash[:success] = message
        # session[:user_id] = @user.id
        redirect_to login_url
      else
        flash[:danger] = "Create account failed!"
        render 'new'
      end
    end

    def get_user
      @user = User.find(params[:id])
    end
    
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
end
