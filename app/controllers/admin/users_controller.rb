class Admin::UsersController < ApplicationController
  before_action :authentication_as_admin_required
  layout "admin"

  def index
    @users = User.all
    respond_to do |f|
      f.html {render :index}
      f.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |f|
      f.html {render :show}
      f.json { render json: @user }
    end
    
  end

  def create
    @user = User.new(user_params)
    @user.projects << Project.find_by(name: "Unsorted")
    if @user.save
      flash[:success] = "You have successfully created a new user, #{@user.username}."

      redirect_to admin_users_path      
    else
      gather_errors(@user)

      render :new
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
    @user.tasks.destroy_all

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
