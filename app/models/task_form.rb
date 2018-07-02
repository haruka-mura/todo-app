class TaskForm
  include ActiveModel::Model
  attr_accessor :title, :description, :user_id, :team_id, :state, :begin_at, :end_at, :task

  delegate :persisted?, to: :task

  def save
    
    new_or_update_or_destroy_task_due_date(end_at)
    new_or_update_or_destroy_completion_date(begin_at)

    task.save
  end

  def task
    @task ||= Task.new(params)
  end

  def new_or_update_or_destroy_task_due_date(end_at)
    return task.task_due_date&.destroy if end_at&.empty?

      t_date = TaskDueDate.find_or_initialize_by(task_id: task.id)
      t_date.end_at = end_at
      task.task_due_date = t_date
  end

  def new_or_update_or_destroy_completion_date(begin_at)
    return task.completion_date&.destroy if begin_at.empty?

      c_date = CompletionDate.find_or_initialize_by(task_id: task.id)
      c_date.begin_at = begin_at
      task.completion_date = c_date
  end

  private

    def params
      {
        title: title,
        description: description,
        user_id: user,
        team_id: team_id,
        state: state,
      }
    end
end
