# frozen_string_literal: true

class ItemGroup < ApplicationRecord
  broadcasts
  has_paper_trail
  belongs_to :project, touch: true, autosave: true, inverse_of: :item_groups, validate: false
  has_many :items, dependent: :destroy, inverse_of: :item_group

  has_rich_text :note

  validates_presence_of :budget
  validates_numericality_of :budget, greater_than_or_equal_to: 0, if: -> { budget.present? }

  def self.policy_class
    ProjectEntityPolicy
  end

  def total_spent
    Money.new(total_spent_on(items.where(purchased: true)))
  end

  def total_allocated
    Money.new(total_spent_on(items))
  end

  private

  def total_spent_on(items)
    items.pluck(:purchase_price_cents, :quantity).reject { |r| r[0].blank? || r[1].blank? }.compact.map { |i| i.inject(:*) }.sum
  end
end
