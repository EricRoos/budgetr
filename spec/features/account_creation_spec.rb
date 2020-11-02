require 'rails_helper'

RSpec.feature "AccountCreations", type: :feature do
  scenario 'creating account' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@foo.com'
    fill_in 'Password', with: 'test123456'
    fill_in 'Password confirmation', with: 'test123456'
    click_on 'Sign up'
    expect(page).to have_content('Projects')
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
