class ExerciseQuestionPolicy < ExercisePolicy
  def index?
    exercise_belongs_to_user?
  end

  def create?
    exercise_belongs_to_user?
  end

  def destroy?
    exercise_belongs_to_user?
  end
end
