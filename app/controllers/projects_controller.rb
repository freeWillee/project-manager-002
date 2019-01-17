class ProjectsController < ApplicationController
  layout "user"
  before_action :authentication_required

  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).projects
    else
      @projects = Project.all
    end
  end

  def show
    if current_user.projects.include?(Project.find(params[:id]))
      @project = Project.find(params[:id])
      @users = @project.users

      if !params[:filter_user_id].blank?
        @tasks = Task.by_user(params[:filter_user_id], params[:id])
      else
        @tasks = @project.tasks.all
      end
    else
      flash[:error] = "You do not have permission to view that project"
      redirect_to user_path(current_user)
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline, user_ids:[])
  end
end
