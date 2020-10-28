# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Item Groupmanagement', type: :feature do
  let(:project) { Project.create(name: 'Foo', budget: 1000) }

  scenario 'User creates a new item group' do
    visit project_path(project)
    click_button 'Add Room'
    fill_in 'Name', with: 'My Room'
    fill_in 'Budget', with: 1000
    click_button 'Create Room'
    expect(page).to have_content('Item group was successfully created.')
  end

  scenario 'delete an item group', js: true do
    item_group = ItemGroup.create(project: project, budget: 100)
    visit project_item_group_path(project, item_group)
    page.accept_confirm do
      click_link 'Delete Room'
    end
    expect(page).to have_content('Item group was successfully destroyed.')
  end
end
