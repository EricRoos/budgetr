module EditLockable
  extend ActiveSupport::Concern

  included do
    has_one :edit_lock, as: :lockable
  end

  def locked_for_edit?
    edit_lock.present?
  end

  def lock_for_editing
    return false if locked_for_edit?
    edit_lock.create
  end

  def unlock_for_edits
    return false unless locked_for_edit?
    edit_lock.destroy
  end
end
