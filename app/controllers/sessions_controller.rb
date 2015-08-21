class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      remember(user)
      self.current_user = user
      redirect_to posts_path
    else
      flash.now[:danger] = "Failed to log in"
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to login_path
  end
end
