class UsersController < ApplicationController
  layout "user", except: [:new, :create]
  before_action :authentication_required
  skip_before_action :authentication_required, only: [:new, :create]  

  def index
    @users = User.all
    
  end

  def show
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You have successfully created a new user, #{@user.username}."
      session[:user_id] = @user.id
      
      redirect_to user_path(@user)      
    else
      gather_errors(@user)

      render :"/users/new"
    end
  end

  def new
    @user = User.new
    render :layout => "application"
    
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.all_user_tasks.destroy_all

    @user.destroy

    redirect_to projects_path
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
