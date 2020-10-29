# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Item Management', type: :feature do
  let(:project) { Project.create(name: 'Foo', budget: 1000) }
  let(:item_group) { ItemGroup.create(project: project, budget: 1000, name: 'foo group') }

  scenario 'User creates a new item', js: true do
    visit project_item_group_path(project, item_group)
    click_button 'Add Item'
    sleep 1
    fill_in 'Name', with: 'My Room'
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
    expect(page).to have_content('Item was successfully destroyed.')
    expect(page).to have_content('No items')
    click_button 'Restore'
    expect(page).to have_content('1 item')
    expect(page).to have_content('Test Item')
  end
end
