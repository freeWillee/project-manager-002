class Admin::ProjectsController < ApplicationController
  before_action :authentication_as_admin_required
  layout "admin"

  def index
    if current_user.is_admin?
      @projects = Project.all

    respond_to do |f|
      f.html {render :index}
      f.json { render json: @projects, status: 200 }
    end

    else
      redirect_to root_path
    end
  end

  def new
    @project = Project.new
  end

  def next
    @project = Project.find(params[:id])
    @next_project = @project.next
    render json: @next_project
  end

  def previous
    @project = Project.find(params[:id])
    @previous_project = @project.previous
    render json: @previous_project
  end

  def create
    @project = Project.new(project_params)
    if !@project.save
      gather_errors(@project)

      render :new
    else
      flash[:success] = "You have successfully created a new project called #{@project.name}."

      redirect_to admin_project_path(@project)
    end
  end

  def show
    @project = Project.find(params[:id])
    @users = @project.users

    if !params[:filter_user_id].blank?
      @tasks = Task.where(user_id: params[:filter_user_id], project_id: params[:id])
    else
      @tasks = @project.tasks.all
    end

    respond_to do |f|
      f.html {render :show}
      f.json { render json: @project, status: 200 }
    end

  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if !@project.update(project_params)
      gather_errors(@project)

      render :edit
    else
      flash[:success] = "You have successfully edited the project."

      redirect_to admin_project_path(@project)
      # render json: @project, status: 200
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.all_project_tasks.destroy_all
    @project.destroy

    flash[:success] = "You have successfully deleted the project, #{@project.name}."
    redirect_to admin_projects_path
    # render json: { projectId: @project.id }
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline, user_ids:[])
  end
end
