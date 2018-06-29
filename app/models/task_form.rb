class TaskForm
  include ActiveModel::Model

  attr_accessor :title, :description, :user, :team_id, :state
  attr_accessor :begin_at
  attr_accessor :end_at
  attr_accessor :task

  delegate :persisted?, to: :task

  def save
    new_or_update_task_due_date(end_at)
    new_or_update_completion_date(begin_at)

    task.save
  end

  def task
    @task ||= Task.new(title: title, description: description, user: user, team_id: team_id, state: state)
  end

  def new_or_update_task_due_date(end_at)
    if end_at.empty?
      task.task_due_date&.destroy
    else
      t_date = TaskDueDate.find_or_initialize_by(task_id: task.id)
      t_date.end_at = end_at
      task.task_due_date = t_date
    end
  end

  def new_or_update_completion_date(begin_at)
    if begin_at.empty?
      task.completion_date&.destroy
    else
      c_date = CompletionDate.find_or_initialize_by(task_id: task.id)
      c_date.begin_at = begin_at
      task.completion_date = c_date
    end
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
end
