class ExercisePolicy < ApplicationPolicy
  def initialize(user, exercise)
    @user = user
    @exercise = exercise
  end

  def update?
    belongs_to_user?
  end

  def show?
    belongs_to_user?
  end

  def destroy?
    belongs_to_user?
  end

  private

  def belongs_to_user?
    @exercise.user == @user
  end
end
