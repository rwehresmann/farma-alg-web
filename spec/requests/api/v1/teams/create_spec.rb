require 'rails_helper'

RSpec.describe "POST /api/v1/teams", type: :request do
  context "when authenticated" do    
    let(:user) { create(:user) }

    context "when data is valid" do
      it "returns code 201" do
        call_endpoint(user, valid_params)

        expect(response).to have_http_status(:created)
      end

      it "creates the team associated with user" do
        expect { call_endpoint(user, valid_params) }.to change(Team, :count).by(1)
        expect(Team.last.user).to eq(user)
      end

      it "sets :teacher role to the user" do
        call_endpoint(user, valid_params)

        expect(user.has_role?(:teacher, Team.last)).to be_truthy
      end
    end

    context "when data is invalid" do
      it "returns code 422" do
        call_endpoint(user, invalid_params)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "doesn't create the Team" do
        expect { call_endpoint(user, invalid_params) }.to_not change(Team, :count)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint }

    it_behaves_like :deny_without_authorization, :post
  end  

  def invalid_params
    { team: attributes_for(:team, name: nil) }
  end

  def valid_params
    { team: attributes_for(:team) }
  end

  def call_endpoint(user, params)
    post get_endpoint, params: params, headers: header_with_authentication(user)
  end

  def get_endpoint
    "/api/v1/teams"
  end
end
