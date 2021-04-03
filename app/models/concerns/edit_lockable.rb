module EditLockable
  extend ActiveSupport::Concern

  included do
    has_one :edit_lock, as: :lockable
  end

  def locked_for_edit?
    edit_lock.present?
  end

  def lock_for_editing(user)
    return false if locked_for_edit?
    EditLock.create!(lockable: self, locked_by: user)
  end

  def locked_by
    return nil unless locked_for_edit?
    edit_lock.locked_by
  end
end
