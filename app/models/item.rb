class Item < ApplicationRecord
  belongs_to :item_group, touch: true
  monetize :purchase_price_cents, allow_nil: true
  has_rich_text :note

  def total_price
    return Money.new(0) unless purchase_price_cents.present?
    purchase_price * quantity 
  end
end
