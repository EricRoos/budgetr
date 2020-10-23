module Projects
  class ItemGroups < BasePresenter
    attr_accessor :item_groups
    def room_count
      count = project.item_groups.size
      return "No rooms" if count == 0
      "#{count} room#{count > 1 ? "s" : ""}"
    end
  end
end
