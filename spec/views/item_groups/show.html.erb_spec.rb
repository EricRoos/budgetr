require 'rails_helper'

RSpec.describe "item_groups/show", type: :view do
  before(:each) do
    @item_group = assign(:item_group, ItemGroup.create!(
      project: nil,
      name: "Name",
      budget: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
