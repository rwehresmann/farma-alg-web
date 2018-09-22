require 'rails_helper'

RSpec.describe "GET /api/v1/exercises/:id", type: :request do
  context "when authenticated" do    
    context "when exercise belongs to user" do
      before do
        @user = create_user_with_exercise
        @exercise = @user.exercises.first
      end

      it "returns code 200" do
        call_endpoint(@user, @exercise.id)

        expect(response).to have_http_status(:success)
      end

      it "returns the right exercise" do
        call_endpoint(@user, @exercise.id)

        expect(response.body).to eq(serialize(ExerciseSerializer, @exercise))  
      end
    end

    context "when exercise doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        exercise = create(:exercise)

        call_endpoint(user, exercise.id)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_with_exercise
    user = create(:user)
    create(:exercise, user: user)

    user
  end

  def call_endpoint(user, exercise_id)
    get get_endpoint(exercise_id), headers: header_with_authentication(user)
  end

  def get_endpoint(exercise_id)
    "/api/v1/exercises/#{exercise_id}"
  end
end
