require 'rails_helper'

RSpec.describe "DELETE /api/v1/class_room/enrollment/teams/:id", type: :request do
  context "when authenticated" do
    before do
      @user = create(:user)
      @team = create(:team, users: [@user])
    end   
    
    it "returns code 204" do
      call_endpoint(@user, @team)

      expect(response).to have_http_status(:no_content)
    end

    it "deletes the team_user" do
      call_endpoint(@user, @team)
      expect(TeamUser.find_by(team: @team, user: @user)).to be_nil
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :delete
  end  


  def call_endpoint(user, team)
    delete get_endpoint(team.id), headers: header_with_authentication(user)
  end

  def get_endpoint(team_id)
    "/api/v1/class_room/enrollment/teams/#{team_id}"
  end
end
