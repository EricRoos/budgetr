class Item < ApplicationRecord
  belongs_to :item_group, touch: true
  monetize :purchase_price_cents, allow_nil: true
  has_rich_text :note

end
