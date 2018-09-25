class TestCasePolicy < QuestionPolicy
  def index?
    question_belongs_to_user?
  end

  def create?
    question_belongs_to_user?
  end

  def destroy?
    return false unless question_belongs_to_user?
    return true unless @question.in_exercises?
    
    single_question_test_case? ? false : true
  end

  private

  def single_question_test_case?
    @question.test_cases.count == 1
  end
end

=begin
      "Test case question is already present in an exercise \
      and currently is the unique test case of this question. \
      To delete it you need first (1) include a second test case for \
      the question or (2) remove its question from any exercise."
=end
