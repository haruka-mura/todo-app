require 'rails_helper'

RSpec.describe TaskDueDate, type: :model do
  describe '#valid?' do
    subject { build :task_due_date, attributes }

    context 'dateが正しく入力された時' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'dateが入力されなかった時' do
      let(:attributes) { { end_at: "" } }

      it { is_expected.to be_invalid }
    end

    context 'dateの値が不正な時' do
      let(:attributes) { { end_at: "aaa" } }

      it { is_expected.to be_invalid }
    end
  end
end
