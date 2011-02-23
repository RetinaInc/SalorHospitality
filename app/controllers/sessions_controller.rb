class SessionsController < ApplicationController

  skip_before_filter :fetch_logged_in_user, :set_locale

  def new
    @users = User.all
    redirect_to orders_path if session[:user_id]
  end
  
  def create
    @current_user = User.find_by_login_and_password params[:login], params[:password]
    @users = User.all
    if @current_user
      redirect_to '/'
      session[:user_id] = @current_user
      flash[:error] = nil
      flash[:notice] = nil
    else
      flash[:error] = t :wrong_password
      render :new
    end
  end

  def destroy
    session[:user_id] = @current_user = nil
    flash[:notice] = t(:logout_successful)
    redirect_to new_session_path
  end

end
