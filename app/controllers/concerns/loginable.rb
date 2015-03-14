module Loginable
  extend ActiveSupport::Concern

  included do
    before_action :redirect_if_logged_in, only: [:new]
  end

  def redirect_if_logged_in
    redirect_to subs_url if current_user
  end

  def login_user!
    session[:token] = @user.get_new_session_token
    @user.save
    redirect_to subs_url
  end
end
