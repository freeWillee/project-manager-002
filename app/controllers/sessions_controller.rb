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

  def fblogin
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = "default"
    end
    
      session[:user_id] = @user.id
      if @user.is_admin?
        redirect_to admin_projects_path
      else
        redirect_to user_path(@user)
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
      flash[:message] = "Invalid username or password.  Please try again."

      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:message] = "You have successfully logged out."
    redirect_to login_path
  end

  private
 
  def auth
    request.env['omniauth.auth']
  end  
end
