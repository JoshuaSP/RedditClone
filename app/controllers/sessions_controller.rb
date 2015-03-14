class SessionsController < ApplicationController
  include Loginable

  skip_before_action :require_login, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login_user!
    else
      flash.now[:errors] = ["Bad username or password"]
      @user = User.new
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.get_new_session_token
    @user.save
    session[:token] = nil
    redirect_to new_session_url
  end
end
