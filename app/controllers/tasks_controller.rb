class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(set_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = "Task created successfully"
      redirect_to tasks_path
    else
      flash[:alert] = "Something wrong"
      render :new
    end

  end

  def edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(set_params)
      flash[:notice] = "Task created successfully"
      redirect_to tasks_path
    else
      flash[:alert] = "Something wrong"
      render :new
    end
  end

  def destroy
    @task.delete
    flash[:notice] = "Task deleted"
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_params
    params.require(:task).permit(
      :priority,
      :content,
      :user_id
    )
  end
end
