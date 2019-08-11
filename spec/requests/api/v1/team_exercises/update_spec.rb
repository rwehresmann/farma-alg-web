require 'rails_helper'

RSpec.describe "PUT /api/v1/team_exercises/:id", type: :request do
  context "when authenticated" do    
    context "when exercise belongs to user" do
      before do
        @user = create(:user)
        @team_exercise = create(:team_exercise, team: create(:team, user: @user), active: false)
      end

      context "when data is valid" do
        it "returns status 204" do
          call_endpoint(@user, @team_exercise.id, valid_params)

          expect(response).to have_http_status(:no_content)
        end
  
        it "updates the team_exercise" do
          call_endpoint(@user, @team_exercise.id, valid_params)

          expect(@team_exercise.reload.active).to eq(valid_params[:team_exercise][:active])
        end
      end

      # Whe realy only have a boolean value to update. Even when nil will be false,
      # so for now there isn't necessary to do this test.
      context "when data is invalid" do
      end
    end

    context "when team_exercise doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        team_exercise = create(:team_exercise)

        call_endpoint(user, team_exercise.id, valid_params)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :put
  end  

  def call_endpoint(user, team_exercise_id, params)
    put get_endpoint(team_exercise_id), params: params, headers: header_with_authentication(user)
  end

  def valid_params
    { team_exercise: { active: true } }
  end

  def invalid_params
    { teamexercise: { active: true } }
  end

  def get_endpoint(team_exercise_id)
    "/api/v1/team_exercises/#{team_exercise_id}"
  end
end
