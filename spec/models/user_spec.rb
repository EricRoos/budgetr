require 'rails_helper'

RSpec.describe User, type: :model do
  let(:project) { Project.create(name: 'p', budget: 1000) }
  let(:user) { User.create(email: 't@1.com', password: 'test123456') }

  describe '#contributing_users' do
    subject { project.contributing_users }

    before do
      project.contributors.create(user: user)
    end

    it { is_expected.to eq [user] }
  end
end
