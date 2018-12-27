class SessionsController < ApplicationController
  def new
    if logged_in?
      if current_user.is_admin?
        redirect_to admin_projects_path
      else
        redirect_to user_path(current_user)
      end
    else
      render :layout => "login"
    end
  end

  def create
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.is_admin?
        redirect_to admin_projects_path
      else
        redirect_to user_path(user)
      end
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
