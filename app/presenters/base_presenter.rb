class BasePresenter
  include ActiveModel::Model

  private

  def entity_count(identifier, count)
    return "No items" if count == 0
    "#{count} #{count > 1 ? identifier.pluralize : identifier}"
  end
end
