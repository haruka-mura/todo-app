class TaskDueDate < ApplicationRecord
  validates :end_at, presence: true
  belongs_to :task
end
