class ProjectsController < ApplicationController
  before_action :authentication_required

  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).projects
    else
      @projects = Project.all
    end
    check_admin_status_for_layout
  end

  def new
    @project = Project.new
    check_admin_status_for_layout
  end

  def create
    @project = Project.create(project_params)

    redirect_to project_path(@project)
  end

  def show
    @project = Project.find(params[:id])
    @users = @project.users

    if !params[:filter_user_id].blank?
      @tasks = Task.where(user_id: params[:filter_user_id], project_id: params[:id])
    else
      @tasks = @project.tasks.all
    end
    check_admin_status_for_layout
  end

  def edit
    @project = Project.find(params[:id])
    check_admin_status_for_layout
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @task = Task.find_by(project_id: @project.id)
    @task.destroy
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline, user_ids:[])
  end
end
