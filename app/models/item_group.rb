# frozen_string_literal: true

class ItemGroup < ApplicationRecord
  has_paper_trail
  belongs_to :project, touch: true, autosave: true, inverse_of: :item_groups
  has_many :items, dependent: :destroy, inverse_of: :item_group

  has_rich_text :note

  validates_numericality_of :budget, greater_than_or_equal_to: 0

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
