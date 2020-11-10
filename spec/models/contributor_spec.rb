require 'rails_helper'

RSpec.describe Contributor, type: :model do
  it 'can be created' do
    user = User.create(email: 'foo@t.com', password: 'test123456')
    project = Project.create(name: 'foo', budget: 100)
    c = Contributor.create(user: user, project: project)
    expect(c).to be_persisted
  end
end
