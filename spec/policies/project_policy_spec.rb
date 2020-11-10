require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  let(:project) { Project.new(name: 'Foo', budget: 100) }
  let(:project_owner) {
    u = User.create(email: 'owner@test.com', password: 'test123456')
    u.add_project(project)
    u
  }

  let(:contributor){
    u = User.create(email: 'contributor@test.com', password: 'test123456')
    Contributor.create(user: u, project: project)
    u
  }

  let(:other) {
    u = User.create(email: 'other@test.com', password: 'test123456')
  }


  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it { is_expected.to permit(project_owner, project) }
    it { is_expected.to permit(contributor, project) }
    it { is_expected.to_not permit(other, project) }
  end

  permissions :new?, :create? do
    it { is_expected.to permit(project_owner, project) }
    it { is_expected.to permit(contributor, project) }
    it { is_expected.to permit(other, project) }
  end

  permissions :update?, :edit?, :destroy? do
    it { is_expected.to permit(project_owner, project) }
    it { is_expected.to_not permit(contributor, project) }
    it { is_expected.to_not permit(other, project) }
  end

end
