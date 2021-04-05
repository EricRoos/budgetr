class UserPolicy < ApplicationPolicy

  def clear_locks?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
