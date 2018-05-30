class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if params[:remember].to_i == 1
      # experied = Time.zone.now + 10.seconds
      # session[:experied] = experied
        cookies.permanent[:remember] = params[:remember].to_i
        cookies.permanent.encrypted[:user_id] = user.id
        # binding.pry
      end
      redirect_to users_path, :notice => "Logged in!"
    else
      redirect_to login_path(@sessions)
    end
  end

  def destroy
    # session[:user_id] = nil
    session.clear
    cookies.delete :user_id
    cookies.delete :remember
    @current_user = nil
    redirect_to login_path
  end
end
