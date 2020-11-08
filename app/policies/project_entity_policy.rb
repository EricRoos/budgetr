class ProjectEntityPolicy < ProjectPolicy

  def restore?
    super || contributes_to_project?
  end

  def index?
    super || contributes_to_project?
  end

  def show?
    super || contributes_to_project?
  end

  def create?
    super || contributes_to_project?
  end

  def new?
    owns_project? || contributes_to_project?
  end

  def update?
    super || contributes_to_project?
  end

  def edit?
    super || contributes_to_project?
  end

  def destroy?
    super || contributes_to_project?
  end

  protected 
    def contributes_to_project?
      project.contributing_users.where(id: user).exists?
    end

    def project
      record.project
    end

  class Scope < Scope
    def resolve
      user.projects.merge(scope)
    end
  end
end
