class SessionsController < ApplicationController
  layout 'account'
  def new
    
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
        # log_in user
        # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # redirect_back_or user
        if params[:remember].to_i == 1
          cookies.permanent[:remember] = params[:remember].to_i
          cookies.permanent.encrypted[:user_id] = user.id
        # binding.pry
        end
        redirect_to root_path, :notice => "Logged in!"
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:notice] = message
        redirect_to root_url
      end

      session[:user_id] = user.id
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
    redirect_to root_path
  end
end
