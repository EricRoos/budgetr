# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Project management', type: :feature do
  let(:project_owner) do
    email = 'foo@test.com'
    password = 'test123456'
    u = User.create(email: email, password: password)
    u.add_project(project)
    u
  end

  let(:contributor) do
    email = 'contrib@test.com'
    password = 'test123456'
    u = User.create(email: email, password: password)
    Contributor.create(project: project, user: u)
    u
  end

  let(:current_user) { project_owner }

  let(:project) do
    Project.new(name: 'My Project', budget: 1000)
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

  scenario 'view projects' do
    project.save
    visit projects_path
    expect(page).to have_content('$1,000')
  end

  context 'as contributor' do
    let(:current_user) { contributor }

    scenario 'viewing projects' do
      visit projects_path
      expect(page).to have_content('Projects')
      expect(page).to have_content(project.name)
    end
  end

  context 'as owner' do
    let(:current_user) { project_owner }

    scenario 'viewing projects' do
      visit projects_path
      expect(page).to have_content('Projects')
      expect(page).to have_content(project.name)
    end
  end
end
