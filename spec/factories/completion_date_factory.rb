FactoryBot.define do
  factory :completion_date do
    begin_at '2018-06-25 08:37:11'
    association :task
  end
end
