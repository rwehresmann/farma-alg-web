module Api
  module V1
    class QuestionsController < ApiController
      before_action :authenticate_user
      
      def index
        render json: serialize(current_user.questions)
      end

      def create
        question = Question.new(
          question_params.merge(user: current_user)
        )

        if question.save
          render json: question, status: :created
        else
          render json: error_structure(question.errors.full_messages), status: :unprocessable_entity
        end
      end

      def update
        question = find_question
        
        authorize(question)

        unless question.update(question_params)
          render json: error_structure(question.errors.full_messages), status: :unprocessable_entity
        end
      end

      def show
        question = find_question

        authorize(question)

        render json: serialize(question)
      end

      def destroy
        question = find_question

        authorize(question)

        question.destroy
      end

      private

      def question_params
        params.require(:question).permit(:title, :description)
      end

      def find_question
        Question.find(params[:id])
      end
    end
  end
end
