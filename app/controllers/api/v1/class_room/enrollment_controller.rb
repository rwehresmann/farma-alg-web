module Api
  module V1
    class ClassRoom::EnrollmentController < ApiController
      before_action :authenticate_user
      
      def create
        team = find_team
        team.received_password = params[:password]

        authorize(team, policy_class: ::ClassRoom::EnrollmentPolicy)

        team_user = TeamUser.new(team: team, user: current_user)

        if team_user.save
          render json: team_user, status: :created
        else
          render json: error_structure(team_user.errors.full_messages), status: :unprocessable_entity
        end
      end

      def destroy
        TeamUser.find_by(team: find_team, user: current_user).destroy
      end

      private

      def find_team
        Team.find(params[:id])
      end
    end
  end
end
