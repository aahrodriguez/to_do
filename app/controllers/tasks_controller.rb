class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :toggle]

  def index
    unless params[:q]
      @tasks = Task.all
    else
      if params[:q] == "high"
        @tasks = Task.all.order(priority: :desc)
      elsif params[:q] == "low"
        @tasks = Task.all.order(priority: :asc)
      elsif params[:q] == "older"
        @tasks = Task.all.order(created_at: :asc)
      elsif params[:q] == "recent"
        @tasks = Task.all.order(created_at: :desc)
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(set_params)
    @task.user = current_user
    if params[:task][:priority] == "High"
      @task.priority = 3
    elsif params[:task][:priority] == "Normal"
      @task.priority = 2
    elsif params[:task][:priority] == "Low"
      @task.priority = 1
    end
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

  def toggle
    value = @task.done
    @task.update(done: !value)
    redirect_to tasks_path
  end

  def tasks_delete
    Task.destroy_all
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
