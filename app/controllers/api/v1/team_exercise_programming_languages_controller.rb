module Api
  module V1
    class TeamExerciseProgrammingLanguagesController < ApiController
      before_action :authenticate_user
      
      def create
        team_exercise = TeamExercise.find(params[:team_exercise_id])
        programming_language = ProgrammingLanguage.find(params[:programming_language_id])

        try_authorize!(team_exercise.team)

        team_exercise_programming_language = TeamExerciseProgrammingLanguage.new(
          team_exercise: team_exercise,
          programming_language: programming_language
        )

        if team_exercise_programming_language.save
          render json: team_exercise_programming_language, status: :created
        else
          render json: error_structure(team_exercise_programming_language.errors.full_messages), status: :unprocessable_entity
        end
      end

      def destroy
        team_exercise_programming_language = TeamExerciseProgrammingLanguage.find(params[:id])

        try_authorize!(team_exercise_programming_language.team)

        team_exercise_programming_language.destroy!
      end

      def try_authorize!(team)
        authorize(team, policy_class: TeamExercisePolicy)
      end
    end
  end
end
