require 'rails_helper'

RSpec.describe "item_groups/new", type: :view do
  before(:each) do
    assign(:item_group, ItemGroup.new(
      project: nil,
      name: "MyString",
      budget: 1
    ))
  end

  it "renders new item_group form" do
    render

    assert_select "form[action=?][method=?]", item_groups_path, "post" do

      assert_select "input[name=?]", "item_group[project_id]"

      assert_select "input[name=?]", "item_group[name]"

      assert_select "input[name=?]", "item_group[budget]"
    end
  end
end
