# frozen_string_literal: true

module Projects
  class ItemGroups < BasePresenter
    attr_accessor :item_groups
    def room_count
      count = project.item_groups.size
      return 'No rooms' if count.zero?

      "#{count} room#{count > 1 ? 's' : ''}"
    end
  end
end
