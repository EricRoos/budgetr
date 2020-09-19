require 'rails_helper'

RSpec.describe "item_groups/index", type: :view do
  before(:each) do
    assign(:item_groups, [
      ItemGroup.create!(
        project: nil,
        name: "Name",
        budget: 2
      ),
      ItemGroup.create!(
        project: nil,
        name: "Name",
        budget: 2
      )
    ])
  end

  it "renders a list of item_groups" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
