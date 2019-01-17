class TasksController < ApplicationController
  layout "user"
  before_action :authentication_required
  skip_before_action :authentication_required, only: [:tasks_by_user]

  def index
    if params[:user_id]
      @tasks = User.find(params[:user_id]).tasks
    else
      @tasks = Task.all
    end    
  end

  def show
    @task = Task.find(params[:id])
    
  end

  def new
    @task = Task.new
    
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if !@task.save
      gather_errors(@task)

      render :new
    else
      flash[:success] = "You have successfully created a task titled, #{@task.title}."

      redirect_to project_path(@task.project)
    end
  end

  def edit
    @task = Task.find(params[:id])
    
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    redirect_to task_path(@task)
  end

  def tasks_by_user

    @user = User.find(2)
    @project = @user.projects.first

    render :layout => false
    
  end

  def almost_done    
    @tasks = Task.almost_done

    render :almost_done
    
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :percent_complete, :project_id, :user_id)
  end

end
