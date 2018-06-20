class AccountActivationsController < BaseController
  def edit
    user = User.find_by(email: params[:email])
    # user = User.find_by(email: current_user.email)
    if user && !user.activated?
      user.activate
      session[:user_id] = user.id
      flash[:success] = "Account activated!"
      redirect_to user
    else
      if user.activated?
        flash[:danger] = "Account already activated!"
      else
        flash[:danger] = "Invalid activation link"
      end
      redirect_to root_path
    end
  end

end
