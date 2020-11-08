# frozen_string_literal: true

class Project < ApplicationRecord
  has_paper_trail

  has_many :item_groups, dependent: :destroy, autosave: true, inverse_of: :project

  has_many :contributors
  has_many :contributing_users, through: :contributors, source: 'user'

  validates_numericality_of :budget, greater_than_or_equal_to: 0

  has_many :user_projects, dependent: :destroy, autosave: true, inverse_of: :project
  has_many :users, through: :user_projects

  # because papertrail problems and the way I chose to restore things
  # i have to do this instead of the has_many through.
  #
  # AR was giving me the business about the way this relationship was setup
  def items
    Item.where(item_group_id: item_groups.collect(&:id))
  end

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
