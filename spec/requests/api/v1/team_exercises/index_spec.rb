require 'rails_helper'

RSpec.describe 'GET /api/v1/teams/:team_id/exercises', type: :request do
  context "when authenticated" do
    before do
      @user = create(:user)
      @team = create(:team, user: @user)
    end

    it "returns code 200" do
      call_endpoint(@user, @team)

      expect(response).to have_http_status(:success)
    end

    it "returns the team exercises" do
      create_team_exercises(@user, @team)
      create_exercises_for_other_teams

      call_endpoint(@user, @team)

      expect(response.body).to eq(serialize(TeamExerciseSerializer, @team.team_exercises))
    end
  end

  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:team)) }

    it_behaves_like :deny_without_authorization, :get
  end  

  private

  def create_team_exercises(user, team)
    exercises = create_list(:exercise, 2, user: user)
    @team.exercises << exercises
  end

  def create_exercises_for_other_teams
    create_list(:team_exercise, 3)
  end

  def call_endpoint(user, team)
    get get_endpoint(team), headers: header_with_authentication(user)
  end

  def get_endpoint(team)
    "/api/v1/teams/#{team.id}/exercises"
  end
end
