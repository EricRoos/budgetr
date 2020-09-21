class Project < ApplicationRecord
  has_many :item_groups
  has_many :items, through: :item_groups

  def budget_remaining
    @budget_remaining ||= (( budget || 0 )- (items.sum(:purchase_price_cents) / 100))
  end

  def allocated_budget
    @allocated_budget ||= item_groups.sum(:budget)
  end

  def budget
    super || 0
  end
end
