class TeamPolicy < ApplicationPolicy
  def initialize(user, team)
    @user = user
    @team = team
  end

  def update?
    team_belongs_to_user?
  end

  def show?
    team_belongs_to_user?
  end

  def destroy?
    team_belongs_to_user?
  end

  protected

  def team_belongs_to_user?
    @team.user == @user
  end
end
