require 'rails_helper'

RSpec.describe "GET /api/v1/teams", type: :request do
  context "when authenticated" do
    let(:user) { create(:user) }

    it "returns code 200" do
      call_endpoint(user)

      expect(response).to have_http_status(:success)
    end

    it "returns the user teams" do
      user_teams = create_user_teams(user)
      create_teams_of_other_users

      call_endpoint(user)
      
      expect(response.body).to eq(serialize(TeamSerializer, user_teams))
    end
  end

  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_teams(user)
    create_list(:team, 2, user: user)    
  end

  def create_teams_of_other_users
    create_list(:team, 3)
  end

  def call_endpoint(user)
    get get_endpoint, headers: header_with_authentication(user)
  end

  def get_endpoint
    '/api/v1/teams'
  end
end
