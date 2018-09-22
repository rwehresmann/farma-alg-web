require 'rails_helper'

RSpec.describe "GET /api/v1/exercises", type: :request do
  context "when authenticated" do
    let(:user) { create(:user) }

    it "returns code 200" do
      call_endpoint(user)

      expect(response).to have_http_status(:success)
    end

    it "returns the user exercises" do
      user_exercises = create_user_exercises(user)
      create_exercises_of_other_users

      call_endpoint(user)

      expect(response.body).to eq(serialize(ExerciseSerializer, user_exercises))
    end
  end

  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_exercises(user)
    create_list(:exercise, 2, user: user)    
  end

  def create_exercises_of_other_users
    create_list(:exercise, 3)
  end

  def call_endpoint(user)
    get get_endpoint, headers: header_with_authentication(user)
  end

  def get_endpoint
    '/api/v1/exercises'
  end
end
