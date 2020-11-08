# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemGroup, type: :model do
  describe 'restore deleted' do
    it 'can restore a project and its item groups' do
      user = User.create(email: 'foo@foo.com', password: 'test123456')
      project = Project.create(name: 'foo', budget: 1500)
      user.add_project(project)
      item_group = project.item_groups.create(name: 'ig1', budget: 1000)
      item_group.items.create(name: 'i1')
      item_group.items.create(name: 'i2')
      item_group.items.create(name: 'i3')
      item_group.destroy
      item_group = item_group.versions.last.reify(has_many: true)
      item_group.save(validate: false)
      item_group.reload
      expect(item_group.valid?).to be true
      expect(item_group.persisted?).to be true
      expect(item_group.items.count).to eq(3)
    end
  end
end
