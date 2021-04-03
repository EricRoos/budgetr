# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it_behaves_like 'edit_lockable'

  describe '#total_price' do
    subject { item.total_price }

    let(:item) { Item.new(quantity: 2, purchase_price_cents: 200) }

    it { is_expected.to eq(Money.new(400)) }
  end
end
