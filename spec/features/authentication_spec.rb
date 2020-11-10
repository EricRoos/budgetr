require 'rails_helper'

RSpec.feature "Authentications", type: :feature do
  scenario 'Logging In' do
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
    expect(page).to have_content('Projects')
  end

  scenario 'Logging out' do
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
    sign_in user
    visit root_path
    click_on 'Sign Out'
    expect(page).to have_content('Log in')
  end
end
