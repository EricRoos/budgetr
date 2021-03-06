class ProjectEntityPolicy < ProjectPolicy
  def restore?
    super || contributes_to_project?
  end

  # def index?
  #  super || contributes_to_project?
  # end

  def show?
    super || contributes_to_project?
  end

  def create?
    owns_project? || contributes_to_project?
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

  def project
    record.project
  end
end
