# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Project management', type: :feature do

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

  scenario 'updating a project' do
    visit edit_project_path(project)
    fill_in 'Budget', with: 1500
    click_on 'Update Project'
    expect(page).to have_content('Project was successfully updated.')
    expect(page).to have_content('$1,500')

  end
end
