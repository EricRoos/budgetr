# frozen_string_literal: true

module ItemGroups
  class ItemGroup < BasePresenter
    attr_accessor :item_group

    def item_group_name
      item_group.name
    end

    def item_count
      count = item_group.items.size
      entity_count('item', count)
    end

    def metrics
      [
        { name: 'Total Budget', help_text: 'Total amount to spend on this room', value: total_budget },
      ]
    end

    def total_budget
      Money.new(100 * (item_group.budget || 0)).format
    end
  end
end
