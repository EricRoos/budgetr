class ProjectPolicy < ApplicationPolicy

  def index?
    owns_project?
  end

  def show?
    owns_project?
  end

  def create?
    owns_project?
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

  protected
    def owns_project?
      UserProject.where(project: project, user: user).exists?
    end

    def project
      record
    end

  class Scope < Scope
    def resolve
      user.projects.merge(scope)
    end
  end
end
