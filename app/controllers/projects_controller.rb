class ProjectsController < ApplicationController
  before_action :authentication_required

  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).projects
    else
      @projects = Project.all
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
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline, user_ids:[])
  end
end
