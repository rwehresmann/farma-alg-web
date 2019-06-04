require 'rails_helper'

RSpec.describe "GET /api/v1/teams/:id", type: :request do
  context "when authenticated" do    
    context "when team belongs to user" do
      before do
        @user = create_user_with_team
        @team = @user.created_teams.first
      end

      it "returns code 200" do
        call_endpoint(@user, @team.id)

        expect(response).to have_http_status(:success)
      end

      it "returns the right team" do
        call_endpoint(@user, @team.id)

        expect(response.body).to eq(serialize(TeamSerializer, @team))  
      end
    end

    context "when team doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        team = create(:team)

        call_endpoint(user, team.id)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_with_team
    user = create(:user)
    create(:team, user: user)

    user
  end

  def call_endpoint(user, team_id)
    get get_endpoint(team_id), headers: header_with_authentication(user)
  end

  def get_endpoint(team_id)
    "/api/v1/teams/#{team_id}"
  end
end
