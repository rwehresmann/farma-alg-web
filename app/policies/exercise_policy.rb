class ExercisePolicy < ApplicationPolicy
  def initialize(user, exercise)
    @user = user
    @exercise = exercise
  end

  def update?
    exercise_belongs_to_user?
  end

  def show?
    exercise_belongs_to_user?
  end

  def destroy?
    exercise_belongs_to_user?
  end

  private

  def exercise_belongs_to_user?
    @exercise.user == @user
  end
end
