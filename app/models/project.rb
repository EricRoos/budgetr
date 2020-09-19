class Project < ApplicationRecord
  has_many :item_groups
  has_many :items, through: :item_groups

  def budget_remaining
    budget - (items.sum(:purchase_price_cents) / 100)
  end
end
