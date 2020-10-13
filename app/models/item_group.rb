class ItemGroup < ApplicationRecord
  has_paper_trail
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
      items.pluck(:purchase_price_cents, :quantity).reject{ |r| r[0].blank? || r[1].blank? }.compact.map{ |i| i.inject(:*) }.sum
    end
end
