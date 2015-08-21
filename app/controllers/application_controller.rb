class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user
    if user_id = cookies[:user_id]
      @current_user ||= User.find_by(remember_token: cookies[:remember_token])
    end
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def sign_out
    session.delete(:user_id)
    cookies.delete :user_id
    cookies.delete :remember_token
    @current_user = nil
  end
end
