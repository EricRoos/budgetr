class ItemGroup < ApplicationRecord
  belongs_to :project, touch: true
  has_many :items, dependent: :delete_all
  has_rich_text :note

  def total_spent
    Money.new(items.where(purchased: true).pluck(:purchase_price_cents).compact.sum)
  end

  def total_allocated
    Money.new(items.pluck(:purchase_price_cents).compact.sum)
  end
end
