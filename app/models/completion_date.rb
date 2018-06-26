class CompletionDate < ApplicationRecord
  validates :begin_at, presence: true
  belongs_to :task
end
