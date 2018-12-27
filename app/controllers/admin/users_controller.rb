class Admin::UsersController < ApplicationController
  before_action :authentication_as_admin_required
  layout "admin"

  def index
    @users = User.all
    
  end

  def show
    @user = User.find(params[:id])
    
  end

  def create
    @user = User.new(user_params)

    raise @user.inspect
    @user.save

    redirect_to admin_user_path(current_user)
  end

  def new
    @user = User.new
    
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to admin_user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.all_user_tasks.destroy_all

    @user.destroy

    redirect_to admin_projects_path
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :admin,
      project_ids:[],
      projects_attributes:[:name, :deadline]
    )
  end
end
