require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      item_group: nil,
      name: "MyString",
      quantity: 1,
      purchase_price_cents: 1
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input[name=?]", "item[item_group_id]"

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[quantity]"

      assert_select "input[name=?]", "item[purchase_price_cents]"
    end
  end
end
