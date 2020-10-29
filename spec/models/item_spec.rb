# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#total_price' do
    let(:item) { Item.new(quantity: 2, purchase_price_cents: 200) }
    subject { item.total_price }
    it { is_expected.to eq(Money.new(400)) }
  end
end
