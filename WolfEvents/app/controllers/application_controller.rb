class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user
  # before_action :authorized
  # before_action :reset_session
  helper_method :logged_in?


  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end

def logged_in?
  !current_user.nil?
end

def authorized
  redirect_to root_path unless current_user
end


