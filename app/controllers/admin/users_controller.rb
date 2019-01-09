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
    @user.projects << Project.find_by(name: "Unsorted")
    if !@user.save
      gather_errors(@user)

      render :new
    else
      flash[:success] = "You have successfully created a new user, #{@user.username}."

      redirect_to admin_users_path
    end
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
    flash[:success] = "You have successfully deleted the user, #{@user.username}."
    
    redirect_to admin_users_path
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
