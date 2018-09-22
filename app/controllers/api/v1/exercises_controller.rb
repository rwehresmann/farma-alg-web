module Api
  module V1
    class ExercisesController < ApiController
      before_action :authenticate_user
      
      def index
        authorize(Exercise)

        render json: serialize(current_user.exercises)
      end
      
      def create
        exercise = Exercise.new(
          exercise_params.merge(user: current_user)
        )

        if exercise.save
          render json: exercise, status: :created
        else
          render json: error_structure(exercise.errors.full_messages), status: :unprocessable_entity
        end
      end

      def update
        exercise = find_exercise
        
        authorize(exercise)

        unless exercise.update(exercise_params)
          render json: error_structure(exercise.errors.full_messages), status: :unprocessable_entity
        end
      end

      def show
        exercise = find_exercise

        authorize(exercise)

        render json: serialize(find_exercise)
      end

      def destroy
        exercise = find_exercise

        authorize(exercise)

        exercise.destroy
      end

      private

      def exercise_params
        params.require(:exercise).permit(:title, :description)
      end

      def find_exercise
        Exercise.find(params[:id])
      end

      def serialize(exercises)
        ExerciseSerializer.new(exercises)
      end
    end
  end
end
