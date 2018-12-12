class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)

    redirect_to admin_projects_path
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline)
  end
end
