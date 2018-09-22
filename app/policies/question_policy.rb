class QuestionPolicy < ApplicationPolicy
  def initialize(user, question)
    @user = user
    @question = question
  end

  def update?
    question_belongs_to_user?
  end

  def show?
    question_belongs_to_user?
  end

  def destroy?
    question_belongs_to_user?
  end

  protected

  def question_belongs_to_user?
    @question.user == @user
  end
end
