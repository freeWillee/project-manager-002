class Admin::TasksController < ApplicationController
  before_action :authentication_as_admin_required
  layout "admin"

  def index
    @tasks = Task.all
    
    respond_to do |f|
      f.html {render :index}
      f.json { render json: @tasks }
    end
  end

  def show
    @task = Task.find(params[:id])
    
  end

  def new
    @task = Task.new(project_id: params[:project_id], user_id: params[:user_id])
    
  end

  def create
    @task = Task.create(task_params)

    # When creating tasks, need to ensure that it is added to the user's project if it already exists, otherwise add the project to user's project list.

    if !@task.save
      gather_errors(@task)

      render :new
    else
      flash[:success] = "You have successfully created a task titled, #{@task.title}."

      redirect_to admin_project_path(@task.project)
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    @task.update(task_params)

    redirect_to admin_task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to admin_projects_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :percent_complete, :project_id, :user_id)
  end

end
