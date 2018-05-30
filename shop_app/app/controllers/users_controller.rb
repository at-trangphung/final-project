class UsersController < ApplicationController

  def index
    @users = User.all
    # binding.pry
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
    @user.update(permit_params)
    redirect_after_update_or_create(@user)
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
      params.require(:user).permit(:first_name, :last_name, :email, :address, :phone)
    end

    def sign_up
      @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end
end
