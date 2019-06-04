require 'rails_helper'

RSpec.describe "PUT /api/v1/teams/:id", type: :request do
  context "when authenticated" do    
    context "when teams belongs to user" do
      before do
        @user = create_user_with_team
        @team = @user.created_teams.first
      end

      context "when data is valid" do
        it "returns status 204" do
          call_endpoint(@user, @team.id, valid_params)

          expect(response).to have_http_status(:no_content)
        end
  
        it "updates the teams" do
          call_endpoint(@user, @team.id, valid_params)

          expect(@team.reload.name).to eq(valid_params[:team][:name])
        end
      end

      context "when data is invalid" do
        it "returns status 402" do
          call_endpoint(@user, @team.id, invalid_params)
        
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "doesn't updates the teams" do
          call_endpoint(@user, @team.id, invalid_params)

          expect(@team.reload.name).to_not eq(invalid_params[:team][:name])          
        end
      end
    end

    context "when team doesn't belongs to the user" do
      it "returns code 403" do
        user = create(:user)
        team = create(:team)

        call_endpoint(user, team.id, valid_params)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :put
  end  

  def create_user_with_team
    user = create(:user)
    
    create(:team, user: user)

    user
  end

  def call_endpoint(user, team_id, params)
    put get_endpoint(team_id), params: params, headers: header_with_authentication(user)
  end

  def valid_params
    { team: { name: 'Team 1' } }
  end

  def invalid_params
    { team: { name: nil } }
  end

  def get_endpoint(team_id)
    "/api/v1/teams/#{team_id}"
  end
end
