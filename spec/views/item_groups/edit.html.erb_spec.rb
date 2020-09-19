require 'rails_helper'

RSpec.describe "item_groups/edit", type: :view do
  before(:each) do
    @item_group = assign(:item_group, ItemGroup.create!(
      project: nil,
      name: "MyString",
      budget: 1
    ))
  end

  it "renders the edit item_group form" do
    render

    assert_select "form[action=?][method=?]", item_group_path(@item_group), "post" do

      assert_select "input[name=?]", "item_group[project_id]"

      assert_select "input[name=?]", "item_group[name]"

      assert_select "input[name=?]", "item_group[budget]"
    end
  end
end
