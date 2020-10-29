# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Project management', type: :feature do
  scenario 'User creates a new project' do
    visit root_path
    click_link 'New Project'
    fill_in 'Name', with: 'My Project'
    fill_in 'Budget', with: 1000
    click_button 'Create Project'
    expect(page).to have_content('Project was successfully created.')
  end

  scenario 'User creates a new project with negative budget' do
    visit root_path
    click_link 'New Project'
    fill_in 'Name', with: 'My Project'
    fill_in 'Budget', with: -1000
    click_button 'Create Project'
    expect(page).to have_content('error')
    expect(page).to have_content('Budget must be greater than or equal to 0')
  end
end
