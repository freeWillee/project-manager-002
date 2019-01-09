class ApplicationController < ActionController::Base
  def authentication_required
    if !logged_in?
      redirect_to login_path
    end
  end

  def authentication_as_admin_required
    if !logged_in? || !current_user.is_admin?
      redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def gather_errors(test_object)
    flash.now[:error] = "Errors found: "
      flash.now[:messages] = []
      test_object.errors.full_messages.each do |message|
        flash.now[:messages] << message
      end
  end

  helper_method :current_user
end
