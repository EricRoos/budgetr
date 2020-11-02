class ProjectPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    owns_project?
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    owns_project?
  end

  def edit?
    owns_project?
  end

  def destroy?
    owns_project?
  end

  private
    def owns_project?
      UserProject.where(project: record, user: user).exists?
    end
  class Scope < Scope
    def resolve
      user.projects.merge(scope)
    end
  end
end
