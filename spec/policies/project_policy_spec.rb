require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  let(:project) { Project.new(name: 'Foo', budget: 100) }
  let(:project_owner) do
    u = User.create(email: 'owner@test.com', password: 'test123456')
    u.add_project(project)
    u
  end

  let(:contributor) do
    u = User.create(email: 'contributor@test.com', password: 'test123456')
    Contributor.create(user: u, project: project)
    u
  end

  let(:other) do
    User.create(email: 'other@test.com', password: 'test123456')
  end

  describe 'Scope' do
    subject { described_class::Scope.new(current_user, Project.all).resolve }

    let(:current_user) { project_owner }

    it { is_expected.to eq [project] }

    context 'when logged as contributor' do
      let(:current_user) { contributor }

      it { is_expected.to eq [project] }
    end

    context 'when not logged' do
      let(:current_user) { nil }

      it { is_expected.to eq [] }
    end
  end

  permissions :show? do
    context 'when project owner' do
      it { is_expected.to permit(project_owner, project) }
    end

    context 'when contributor' do
      it { is_expected.to permit(contributor, project) }
    end

    context 'when other' do
      it { is_expected.not_to permit(other, project) }
    end
  end

  permissions :new?, :create? do
    context 'when project owner' do
      it { is_expected.to permit(project_owner, project) }
    end

    context 'when contributor' do
      it { is_expected.to permit(contributor, project) }
    end

    context 'when other' do
      it { is_expected.to permit(other, project) }
    end
  end

  permissions :update?, :edit?, :destroy? do
    context 'when project owner' do
      it { is_expected.to permit(project_owner, project) }
    end

    context 'when contributor' do
      it { is_expected.not_to permit(contributor, project) }
    end

    context 'when other' do
      it { is_expected.not_to permit(other, project) }
    end
  end
end
