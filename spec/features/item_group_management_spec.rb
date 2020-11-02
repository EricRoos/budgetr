# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Item Groupmanagement', type: :feature do
  let(:current_user) {
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
  }
  let(:project_owner) { current_user }

  let(:project) do
    project = Project.new(name: 'foo', budget: 1000)
    project_owner.add_project(project)
    project
  end

  before do
    sign_in current_user
  end

  scenario 'User creates a new item group' do
    visit project_path(project)
    click_button 'Add Room'
    fill_in 'Name', with: 'My Room'
    fill_in 'Budget', with: 1000
    click_button 'Create Room'
    sleep 2
    expect(page).to have_content('Item group was successfully created.')
  end

  scenario 'delete an item group', js: true do
    item_group = ItemGroup.create(project: project, budget: 100, name: 'My Room')
    visit project_item_group_path(project, item_group)
    page.accept_confirm do
      click_link 'Delete Room'
    end
    expect(page).to have_content('Item group was successfully destroyed.')
    expect(page).to have_content('No rooms')
    click_button 'Restore'
    expect(page).to have_content('1 room')
    expect(page).to have_content('My Room')
  end
end
