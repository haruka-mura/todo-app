class TaskForm
  include ActiveModel::Model

  attr_accessor :title, :description, :user, :team_id, :state
  attr_accessor :begin_at
  attr_accessor :end_at
  attr_reader :task

  delegate :persisted?, to: :task

  def initialize(task, attributes = {})
    @task = task
    super(attributes)
  end

  def save
    @task = Task.new(task_params)
    @task.build_completion_date(begin_at: begin_at) if begin_at.present?
    @task.build_task_due_date(end_at: end_at) if end_at.present?
    @task.save
  end

  # def task
  #   @task ||= Task.new(params)
  # end

  def update
    if CompletionDate.exists?(task_id: task.id)
      if begin_at.empty?
        task.completion_date.destroy
      else
        task.completion_date.update(begin_at: begin_at)
      end
    else
        task.build_completion_date(begin_at: begin_at)
    end

    if TaskDueDate.exists?(task_id: task.id)
      if end_at.empty?
        task.task_due_date.destroy
      else
        task.task_due_date.update(end_at: end_at)
      end
    else
      task.build_task_due_date(end_at: end_at)
    end

    task.save
    task.update(params)
  end

  private

    def params
      {
        title: title,
        description: description,
        user: user,
        team_id: team_id,
        state: state,
      }
    end

    def task_params
      { title: title, description: description, user: user, team_id: team_id, state: state }
    end
end
