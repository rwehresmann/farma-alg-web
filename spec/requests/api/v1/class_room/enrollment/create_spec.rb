require 'rails_helper'

RSpec.describe "POST /api/v1/class_room/enrollment/teams/:id", type: :request do
  context "when authenticated" do
    let(:user) { create(:user) }

    context "when team password is correct" do
      context "when user isn't already enrolled in this team" do
        it "returns code 201" do
          team = create(:team)

          call_endpoint(user, team, team.password)
  
          expect(response).to have_http_status(:created)
        end

        it "enrolls the user (student)" do
          team = create(:team)

          call_endpoint(user, team, team.password)

          expect(TeamUser.find_by(user: user, team: team)).to_not be_nil
        end
      end

      context "when user is already enrolled" do
        let!(:team) { create(:team, users: [user]) }

        it "returns code 403" do
          call_endpoint(user, team, team.password)
  
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "doesn't enroll the user again" do
          expect { call_endpoint(user, team, team.password) }.to_not change(TeamUser, :count)
        end
      end

      context "when user is the team teacher" do
        it "doesn't enroll the user again" do
          team = TeamService::Creator.new(attributes_for(:team).merge(user: user)).call

          expect { call_endpoint(user, team, team.password) }.to_not change(TeamUser, :count)
        end
      end
    end

    context "when team password is incorrect" do
      it "doesn't enroll the user" do
        team = create(:team)

        expect { call_endpoint(user, team, team.password.reverse) }.to_not change(TeamUser, :count)
      end
    end
  end
  
  context "when unauthenticated" do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :post
  end

  def call_endpoint(user, team, enrollment_password)
    post get_endpoint(team.id), params: { password: enrollment_password }, headers: header_with_authentication(user)
  end

  def get_endpoint(team_id)
    "/api/v1/class_room/enrollment/teams/#{team_id}"
  end
end
