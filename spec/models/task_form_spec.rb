require 'rails_helper'

RSpec.describe TaskForm, type: :model do
  describe '#save' do
    subject { task_form.save }

    let(:user) { create(:user) }
    let(:team) { create(:team, users: [user]) }
    let(:begin_at) { Time.zone.now }
    let(:end_at) { Time.zone.now }
    let(:task_params) { attributes_for :task, team_id: team.id, end_at: end_at, begin_at: begin_at }
    let(:task_form) { TaskForm.new(task_params.merge(user: user)) }

    context 'saveに成功する時' do

      it { is_expected.to be_truthy }
    end

    context 'titleが入力されない場合' do
      let(:task_params) { attributes_for :task, title: "", team_id: team.id, end_at: end_at, begin_at: begin_at }

      it { is_expected.to be_falsey }
    end
  end
end
