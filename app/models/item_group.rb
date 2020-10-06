class ItemGroup < ApplicationRecord
  belongs_to :project, touch: true
  has_many :items, dependent: :delete_all
  has_rich_text :note

  def total_spent
    Money.new(total_spent_on(items.where(purchased: true)))
  end

  def total_allocated
    Money.new(total_spent_on(items))
  end

  private
    def total_spent_on(items)
      items.pluck(:purchase_price_cents, :quantity).compact.map{ |i| i.inject(:*) }.sum
    end
end
