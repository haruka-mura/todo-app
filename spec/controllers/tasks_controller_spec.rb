require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#index" do
    subject { get :index }

    context 'ログインしている時' do
      let(:task) { create(:task) }

      before { log_in task.user }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:tasks)).to contain_exactly task
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#show" do
    subject { get :show, params: { id: task_id } }

    let(:task) { create(:task) }
    let(:task_id) { task.id }

    before do
      log_in task.user
    end

    context 'when id is valid' do
      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:task)).to eq task
      end
    end

    context 'when id is invalid' do
      let(:task_id) { 'aaa' }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "#new" do
    subject { get :new }

    let(:user) { create(:user, teams: create_list(:team, 2)) }

    before { log_in user }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:task_form).class).to eq TaskForm
    end
  end

  describe "#create" do
    subject do
      post :create, params: { task_form: task_params}
    end

    let(:user) { create(:user) }
    let(:team) { create(:team, users: [user]) }
    let(:params) { attributes_for :task, team_id: team.id }
    let(:task_params) { params.merge(user_id: user, end_at: end_at[:end_at], begin_at: begin_at[:begin_at]) }
    let(:begin_at) { attributes_for :completion_date }
    let(:end_at) { attributes_for :task_due_date }

    context 'ログインしている時' do
      before { log_in user }

      context "with valid params" do
        it :aggregate_failures do
          expect { subject }.to change { Task.count }.by(1)
          expect(response).to redirect_to(Task.last)
          expect(assigns(:task_form).user_id).to eq user.id
        end
      end

      context "with invalid params" do
        let(:task_params) { attributes_for :task, title: "", team_id: team.id, end_at: end_at[:end_at], begin_at: begin_at[:begin_at] }

        it do
          expect { subject }.not_to change { Task.count }
          expect(response).to render_template :new
          expect(assigns(:task_form).user_id).to eq user.id
        end
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end
end
