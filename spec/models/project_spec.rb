require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#budget_remaining' do
    let(:budget) { 1000 }
    let(:project) { Project.create(name: :foo, budget: budget) }
    let(:purchase_price_cents) { 200 }
    let(:quantity) { 2 }
    before do
      item_group = project.item_groups.create(name: :foo, budget: 1000)
      item_group.items.create(name: :foo, purchase_price_cents: purchase_price_cents, quantity: quantity)
    end
    subject { project.budget_remaining }
    it { is_expected.to eq 996 }

    context 'when purchase price is more than the budget' do
      let(:purchase_price_cents) { 100100 }
      let(:quantity) { 1 }
      it { is_expected.to eq -1 }
    end
  end
end
