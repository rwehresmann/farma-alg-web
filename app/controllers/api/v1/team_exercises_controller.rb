module Api
  module V1
    class TeamExercisesController < ApiController
      before_action :authenticate_user
      
      def index
        team = find_team

        try_authorize!(team)

        render json: serialize(team.team_exercises)
      end

      def show
        team_exercise = find_team_exercise

        try_authorize!(team_exercise.team)

        render json: serialize(team_exercise)
      end

      def create
        team = find_team

        try_authorize!(team)

        team_exercise = TeamExercise.new(team_exercise_params.merge(team: team, exercise: find_exercise))

        if team_exercise.save
          render json: team_exercise, status: :created
        else
          render json: error_structure(team_exercise.errors.full_messages), status: :unprocessable_entity
        end
      end

      def update
        team_exercise = find_team_exercise

        try_authorize!(team_exercise.team)

        unless team_exercise.update(team_exercise_params)
          render json: error_structure(team_exercise.errors.full_messages), status: :unprocessable_entity
        end
      end

      def destroy
        team_exercise = find_exercise

        try_authorize!(team_exercise.team)

        team_exercise.destroy
      end

      private

      def team_exercise_params
        params.require(:team_exercise).permit(:active)
      end

      def find_team
        Team.find(params[:team_id])
      end

      def find_exercise
        Exercise.find(params[:exercise_id])
      end

      def find_team_exercise
        TeamExercise.find(params[:id])
      end

      def try_authorize!(team)
        authorize(team, policy_class: TeamExercisePolicy)
      end
    end
  end
end
