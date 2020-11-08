# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#budget_remaining' do
    subject { project.budget_remaining }

    let(:budget) { 1000 }
    let(:project) { Project.create(name: :foo, budget: budget) }
    let(:purchase_price_cents) { 200 }
    let(:quantity) { 2 }

    before do
      item_group = project.item_groups.create(name: :foo, budget: 1000)
      item_group.items.create(name: :foo, purchase_price_cents: purchase_price_cents, quantity: quantity)
    end

    it { is_expected.to eq 996 }

    context 'when purchase price is more than the budget' do
      let(:purchase_price_cents) { 100_100 }
      let(:quantity) { 1 }

      it { is_expected.to eq(-1) }
    end

    context 'purchase_price is nil' do
      let(:purchase_price_cents) { nil }

      it { is_expected.to eq budget }
    end
  end

  describe 'restore deleted' do
    it 'can restore a project and its item groups' do
      user = User.create(email: 'foo@foo.com', password: 'test123456')
      project = Project.create(name: 'foo', budget: 1500)
      user.add_project(project)
      project.item_groups.create(name: 'ig1', budget: 1000)
      project.item_groups.create(name: 'ig1', budget: 1000)
      project.item_groups.create(name: 'ig1', budget: 1000)
      project.destroy
      project = project.versions.last.reify(has_many: true, belongs_to: true, has_one: true)
      project.save(validate: false)
      project.reload
      user.reload
      expect(project.valid?).to be true
      expect(project.persisted?).to be true
      expect(project.item_groups.count).to eq(3)
      expect(Project.all.count).to eq(1)
    end
  end
end
