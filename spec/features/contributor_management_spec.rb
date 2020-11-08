require 'rails_helper'

RSpec.feature "Contributor Management", type: :feature do
  let(:current_user) {
    project_owner
  }

  let(:project_owner) {
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
  }

  let(:project) do
    project = Project.new(name: 'foo', budget: 1000)
    project_owner.add_project(project)
    project
  end

  before do
    sign_in current_user
  end

  let(:new_contributing_user) { User.create(email: 'contrib@1.com', password: 'test123456') }
  scenario 'Adds a contributor' do
    visit edit_project_path(project)
    click_on "Add Contributor"
    fill_in "Email", with: new_contributing_user.email
    click_on "Create Contributor"
    expect(page).to have_content('Contributor was successfully created.')
  end

  scenario 'Fails to add a contributor' do
    visit edit_project_path(project)
    click_on "Add Contributor"
    fill_in "Email", with: 'notfound@no.com'
    click_on "Create Contributor"
    expect(page).to have_content('1 error')
    expect(page).to have_content('User must exist')
  end

  scenario 'delete a contributor', js: true do
    Contributor.create(project: project, user: new_contributing_user)
    visit edit_project_path(project)
    page.accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Contributor was successfully destroyed.')
  end
end
