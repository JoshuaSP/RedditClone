class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user

  def current_user
    User.find_by_session_token(session[:token])
  end

  def require_login
    redirect_to new_session_url if current_user.nil?
  end
end
