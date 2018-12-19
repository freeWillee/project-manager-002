class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new(project_id: params[:project_id])
  end

  def create
    raise params.inspect
    @task = Task.create(task_params)

    redirect_to task_path(@task)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    redirect_to task_path(@task)
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :percent_complete, :project_id, :user_id)
  end

end
