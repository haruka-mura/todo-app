require 'rails_helper'

RSpec.describe TaskDueDate, type: :model do
  describe '#valid?' do
    subject { build :task_due_date, attributes }

    let(:attributes) { {} }
    
    it { is_expected.to be_valid }
  end
end
