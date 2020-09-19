require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        item_group: nil,
        name: "Name",
        quantity: 2,
        purchase_price_cents: 3
      ),
      Item.create!(
        item_group: nil,
        name: "Name",
        quantity: 2,
        purchase_price_cents: 3
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
