require 'rails_helper'

RSpec.describe "GET /api/v1/team_exercises/:id", type: :request do
  context "when authenticated" do    
    context "when team belongs to user" do
      before do
        @user = create(:user)
        @team = create(:team, user: @user)
        @team_exercise = create(:team_exercise, team: @team)
      end

      it "returns code 200" do
        call_endpoint(@user, @team_exercise.id)

        expect(response).to have_http_status(:success)
      end

      it "returns the right team_exercise" do
        call_endpoint(@user, @team_exercise.id)

        expect(response.body).to eq(serialize(TeamExerciseSerializer, @team_exercise))  
      end
    end

    context "when team doesn't belongs to the user" do
      it "returns code 403" do
        user = create(:user)
        team_exercise = create(:team_exercise)

        call_endpoint(user, team_exercise.id)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def call_endpoint(user, team_exercise_id)
    get get_endpoint(team_exercise_id), headers: header_with_authentication(user)
  end

  def get_endpoint(team_exercise_id)
    "/api/v1/team_exercises/#{team_exercise_id}"
  end
end
