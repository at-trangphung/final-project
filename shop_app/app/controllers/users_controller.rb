class UsersController < ApplicationController

  def index
    @users = User.all
    # binding.pry
  end

  def show
    @user = User.find(params[:id])
    redirect_to login_path 
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

    if @user.update(user_params)
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
    redirect_to user_index_path  
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    def sign_up
      @user = User.new(user_params)
      # binding.pry
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end
end
