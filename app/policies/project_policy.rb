class ProjectPolicy < ApplicationPolicy
  def restore?
    owns_project?
  end

  def index?
    true
  end

  def show?
    owns_project? || contributes_to_project?
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

  protected

  def owns_project?
    UserProject.where(project: project, user: user).exists?
  end

  def contributes_to_project?
    project.contributing_users.where(id: user).exists?
  end

  def project
    record
  end

  class Scope < Scope
    def resolve
      return [] unless user && user.persisted?
      user.projects + Project.where(id: Contributor.where(user_id: user).pluck(:project_id))
    end
  end
end
