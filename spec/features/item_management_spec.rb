# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Item Management', type: :feature do
  let(:item_group) { ItemGroup.create(project: project, budget: 1000, name: 'foo group') }
  let(:current_user) do
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
  end
  let(:project_owner) { current_user }

  let(:project) do
    project = Project.new(name: 'foo', budget: 1000)
    project_owner.add_project(project)
    project
  end

  before do
    sign_in current_user
  end

  scenario 'User creates a new item', js: true do
    visit project_item_group_path(project, item_group)
    click_button 'Add Item'
    sleep 1
    fill_in 'Name', with: 'Name'
    fill_in 'Quantity', with: 10
    fill_in 'Price', with: '1.99'
    click_button 'Create Item'
    expect(page).to have_content('1 item')
  end

  scenario 'delete an item', js: true do
    Item.create(item_group: item_group, purchase_price: 1.99, quantity: 1, name: 'Test Item')
    visit project_item_group_path(project, item_group)
    page.accept_confirm do
      click_link 'Destroy'
    end
    expect(page).to have_content('No items')
  end
end
