# frozen_string_literal: true

class BasePresenter
  include ActiveModel::Model

  private

  def entity_count(identifier, count)
    return 'No items' if count.zero?

    "#{count} #{count > 1 ? identifier.pluralize : identifier}"
  end
end
