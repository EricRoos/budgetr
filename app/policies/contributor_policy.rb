class ContributorPolicy < ProjectPolicy
  def restore?
    owns_project?
  end

  def create?
    owns_project?
  end

  def new?
    owns_project?
  end

  def destroy?
    owns_project?
  end

  protected

  def project
    record.project
  end
end
