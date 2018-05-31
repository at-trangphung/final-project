class UsersController < ApplicationController
  layout 'account'
  
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
    @user = User.find(params[:id])
  end

  def create
    sign_up 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(permit_params)
      flash[:success] = 'update profile successed'
      redirect_to @user
    else
      render 'edit'
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    cookies.delete :user_id
    cookies.delete :remember
    @current_user = nil
    redirect_to login_path  
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    def permit_params
      params.require(:user).permit(:first_name, :last_name, :email, :address, :phone, :avatar)
    end

    def sign_up
      @user = User.new(user_params)
      if @user.save
        # UserMailerPreview.account_activation(@user).deliver_now
        # UserMailer.with(user: @user).welcome_email.deliver_later
        @user.send_activation_email

        flash[:notice] = "Please check your email to activate your account."
        redirect_to root_url
        # redirect_to @user
      else
        render 'new'
      end
    end

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
end
