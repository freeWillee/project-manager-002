class ApplicationController < ActionController::Base
  def authentication_required
    if !logged_in?
      redirect_to login_path
    end
  end

<<<<<<< HEAD
  def check_admin_status_for_layout
    @admin = User.find(session[:user_id])
    if @admin.is_admin?
      if params[:id] && User.find(params[:id])
        @user = User.find(params[:id])
      end
      render :layout => "admin"
    end
  end

=======
>>>>>>> 661eb49ef71831a9083026f8fb989ccd60b05b7f
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
