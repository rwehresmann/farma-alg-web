class TeamExercisePolicy < TeamPolicy
  def index?
    team_belongs_to_user?
  end

  def show?
    team_belongs_to_user?
  end

  def create?
    team_belongs_to_user?
  end

  def destroy?
    team_belongs_to_user?
  end
end
