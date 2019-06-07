module Api
  module V1
    class TestCasesController < ApiController
      before_action :authenticate_user
      
      def index
        question = find_question

        try_authorize!(question)

        render json: serialize(question.test_cases)
      end

      def create
        question = find_question

        test_case = TestCase.new(
          test_case_params.merge(question: question)
        )

        try_authorize!(question)

        if test_case.save
          render json: test_case, status: :created
        else
          render json: error_structure(test_case.errors.full_messages), status: :unprocessable_entity
        end
      end

      def show
        test_case = find_test_case

        try_authorize!(test_case.question)

        render json: serialize(test_case)
      end

      def update
        test_case = find_test_case
        
        try_authorize!(test_case.question)

        unless test_case.update(test_case_params)
          render json: error_structure(test_case.errors.full_messages), status: :unprocessable_entity
        end
      end

      def destroy
        test_case = find_test_case
        question = test_case.question

        try_authorize!(question)

        test_case.destroy
      end

      private

      def test_case_params
        params.require(:test_case).permit(:input, :output)
      end

      def find_test_case
        TestCase.find(params[:id])
      end

      def find_question
        Question.find(params[:question_id])
      end

      # Don't know why, but if I don't especify `policy_class`, it's getting 
      # QuestionPolicy instead.
      def try_authorize!(question)
        authorize(question, policy_class: TestCasePolicy)
      end
    end
  end
end
