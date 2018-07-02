class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task_form = TaskForm.new
  end

  def edit
    @task_form = TaskForm.new(task_params.merge(task: @task))
  end

  def create
    @task_form = TaskForm.new task_form_params.merge(user: current_user)

    if @task_form.save
      redirect_to @task_form.task, notice: 'task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task_form = TaskForm.new(task_form_params.merge(user_id: current_user, task: @task))
    if @task_form.save
      redirect_to task_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_form_params
    params.require(:task_form).permit(:title, :description, :end_at, :begin_at, :team_id, :state)
  end

  def task_params
    {
      title: @task.title,
      description: @task.description,
      user_id: @task.user_id,
      team_id: @task.team_id,
      state: @task.state,
      end_at: @task.task_due_date&.end_at,
      begin_at: @task.completion_date&.begin_at
    }
  end
end
