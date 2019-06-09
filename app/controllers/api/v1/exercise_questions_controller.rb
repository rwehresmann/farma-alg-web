module Api
  module V1
    class ExerciseQuestionsController < ApiController
      before_action :authenticate_user
      
      def index
        exercise = find_exercise

        try_authorize!(exercise)

        render json: QuestionSerializer.new(exercise.questions)
      end

      def create
        exercise = find_exercise

        try_authorize!(exercise)

        exercise_question = ExerciseQuestion.new(exercise: exercise, question: find_question)

        if exercise_question.save
          render json: exercise_question, status: :created
        else
          render json: error_structure(exercise_question.errors.full_messages), status: :unprocessable_entity
        end
      end

      def destroy
        try_authorize!(find_exercise)
        
        exercise_question = ExerciseQuestion.find_by!(
          exercise_id: params[:exercise_id], 
          question_id: params[:question_id]
        ) 

        exercise_question.destroy
      end

      private

      def find_exercise
        Exercise.find(params[:exercise_id])
      end

      def find_question
        Question.find(params[:question_id])
      end

      def try_authorize!(exercise)
        authorize(exercise, policy_class: ExerciseQuestionPolicy)
      end
    end
  end
end
