class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :state, presence: true

  has_one :task_due_date
  has_one :completion_date
  belongs_to :user
  belongs_to :team

  enum state: { registered: 0, assigned: 1, completed: 2 }

  scope :with_begin_at, -> { joins(:completion_date) }
  scope :with_end_at, -> { joins(:task_due_date) }

  def self.with_no_date
    scope = self.joins(:task_due_date)
    scope = self.where(scope.exists.not).all
    scope
  end

  # def condition
  #
  # end
end
