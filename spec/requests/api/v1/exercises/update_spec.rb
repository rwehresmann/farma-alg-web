require 'rails_helper'

RSpec.describe "PUT /api/v1/exercises/:id", type: :request do
  context "when authenticated" do    
    context "when exercise belongs to user" do
      before do
        @user = create_user_with_exercise
        @exercise = @user.exercises.first
      end

      context "when data is valid" do
        it "returns status 204" do
          call_endpoint(@user, @exercise.id, valid_params)

          expect(response).to have_http_status(:no_content)
        end
  
        it "updates the exercise" do
          call_endpoint(@user, @exercise.id, valid_params)

          expect(@exercise.reload.title).to eq(valid_params[:exercise][:title])
        end
      end

      context "when data is invalid" do
        it "returns status 402" do
          call_endpoint(@user, @exercise.id, invalid_params)
        
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "doesn't updates the exercise" do
          call_endpoint(@user, @exercise.id, invalid_params)

          expect(@exercise.reload.title).to_not eq(invalid_params[:exercise][:title])          
        end
      end
    end

    context "when exercise doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        exercise = create(:exercise)

        call_endpoint(user, exercise.id, valid_params)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :put
  end  

  def create_user_with_exercise
    user = create(:user)
    
    create(:exercise, user: user)

    user
  end

  def call_endpoint(user, exercise_id, params)
    put get_endpoint(exercise_id), params: params, headers: header_with_authentication(user)
  end

  def valid_params
    { exercise: { title: 'A new test for today' } }
  end

  def invalid_params
    { exercise: { title: nil } }
  end

  def get_endpoint(exercise_id)
    "/api/v1/exercises/#{exercise_id}"
  end
end
