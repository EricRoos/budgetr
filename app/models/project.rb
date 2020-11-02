# frozen_string_literal: true

class Project < ApplicationRecord
  has_paper_trail
  has_many :item_groups
  has_many :items, through: :item_groups
  validates_numericality_of :budget, greater_than_or_equal_to: 0

  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  def budget_remaining
    item_price_sum = items.map do |i|
      quantity = i.quantity || 1
      if i.purchase_price_cents
        i.purchase_price_cents * quantity
      else
        0
      end
    end.sum
    @budget_remaining ||= ((budget || 0) - (item_price_sum / 100))
  end

  def allocated_budget
    @allocated_budget ||= item_groups.sum(:budget)
  end

  def budget
    super || 0
  end
end
