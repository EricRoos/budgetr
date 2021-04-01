# frozen_string_literal: true

class Item < ApplicationRecord
  broadcasts
  has_paper_trail
  belongs_to :item_group, touch: true, inverse_of: :items
  has_one :project, through: :item_group
  monetize :purchase_price_cents, allow_nil: true
  has_rich_text :note

  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  def self.policy_class
    ProjectEntityPolicy
  end

  def total_price
    return Money.new(0) if purchase_price_cents.blank?

    purchase_price * quantity
  end
end
