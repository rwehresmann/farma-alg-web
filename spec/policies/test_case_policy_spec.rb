require 'rails_helper'

RSpec.describe TestCasePolicy do
  permissions :index?, :create?, :update?, :show? do
    it "denies access if question doesn't belongs to the user" do
      expect(described_class).not_to permit(create(:user), create(:question))
    end

    it "grants access if question belongs to the user" do
      user = create(:user)
      question = create(:question, user: user)

      expect(described_class).to permit(user, question)
    end
  end

  describe "#destroy?" do
    let(:user) { create(:user) }

    context "when question belongs to user" do
      let(:question) { create(:question, user: user) }

      before do
        @question = create(:question, user: user)
        @policy = described_class.new(user, @question)
      end

      context "when question is already associated with an exercise" do
        before { create(:exercise, questions: [ @question ]) }
        
        context "when this is the only test case of the question" do
          it "denies access" do
            create(:test_case, question: @question)

            expect(@policy.destroy?).to be_falsey
          end 
        end

        context "when there are more test cases associated with the question" do
          it "grants access" do
            create_list(:test_case, 2, question: @question)

            expect(@policy.destroy?).to be_truthy
          end
        end
      end

      context "when question isn't associated with an exercise" do
        it "grants access" do
          create(:test_case, question: @question)

          expect(@policy.destroy?).to be_truthy
        end
      end
    end

    context "when question doesn't belongs to user" do
      it "denies access" do
        test_case = create(:test_case)
        policy = TestCasePolicy.new(user, test_case.question)

        expect(policy.destroy?).to be_falsey
      end
    end
  end

  def create_user_question_with_exercise(user)
    exercise = create(:exercise, user: user)
    question = create(:question, user: user)

    exercise.questions << question

    question
  end
end
