module Api
  module V1
    class TeamsController < ApiController
      before_action :authenticate_user
          
      def index
        render json: serialize(current_user.created_teams)
      end

      def create
        team_creator = TeamService::Creator.new(team_params.merge(user: current_user))
        team = team_creator.call

        if team.persisted?
          render json: team, status: :created
        else
          render json: error_structure(team.errors.full_messages), status: :unprocessable_entity
        end
      end

      def update
        team = find_team
        
        authorize(team)

        unless team.update(team_params)
          render json: error_structure(team.errors.full_messages), status: :unprocessable_entity
        end
      end

      def show
        team = find_team

        authorize(team)

        render json: serialize(team)
      end

      private

      def team_params
        params.require(:team).permit(:name, :description, :password)
      end

      def find_team
        Team.find(params[:id])
      end
    end
  end
end
