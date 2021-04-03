# frozen_string_literal: true

module ItemsHelper
  def editable?(item, current_user)
    return true unless item.locked_for_edit?
    item.locked_by == current_user
  end
end
