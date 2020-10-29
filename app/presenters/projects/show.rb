# frozen_string_literal: true

module Projects
  class Show < BasePresenter
    attr_accessor :project

    def project_name
      project.name
    end

    def callout_boxes
      [
        { title: 'Total Spent', content: total_spent },
        { title: 'Total Allocated', content: total_allocated },
        { title: 'Budget', content: budget },
      ]
    end

    def total_spent
      (project.item_groups.map(&:total_spent).inject(:+) || Money.new(0)).format
    end

    def total_allocated
      (project.item_groups.map(&:total_allocated).inject(:+) || Money.new(0)).format
    end

    def budget
      Money.new(project.budget || 0).format
    end

    def room_count
      count = project.item_groups.size
      return 'No rooms' if count.zero?

      "#{count} room#{count > 1 ? 's' : ''}"
    end
  end
end
