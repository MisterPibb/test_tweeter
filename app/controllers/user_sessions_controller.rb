# app/controllers/user_sessions_controller.rb
class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
    if current_user
      redirect_to posts_path
    else
      @user = User.new
    end
  end

  def create
    if @user = login(params[:email], params[:password])
      root_path
      redirect_to root_path
    else
      redirect_to new_user_session_path
      flash[:alert] = 'Login Failed'
    end
  end

  def destroy
    logout
    redirect_to login_path
    flash[:success] = 'Logged Out'
  end
end
