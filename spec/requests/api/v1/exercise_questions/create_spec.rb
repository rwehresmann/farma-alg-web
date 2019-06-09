require 'rails_helper'

RSpec.describe "POST /api/v1/exercises/:exercise_id/questions/:question_id", type: :request do
  context "when authenticated" do    
    let!(:user) { create(:user) }

    context "when exercise belongs to the user" do
      before do
        @question = create(:question)
        @exercise = create(:exercise, user: user)
      end
      
      it "returns code 201" do
        call_endpoint(user, @exercise, @question)

        expect(response).to have_http_status(:created)
      end

      it "adds the question to the exercise" do
        call_endpoint(user, @exercise, @question)

        expect(@exercise.questions).to include(@question)
      end
    end

    context "when exercise doesn't belongs to the user" do
      let(:exercise) { create(:exercise) }
      let(:question) { create(:question) }
      
      it "returns code 422" do
        call_endpoint(user, exercise, question)

        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't adds the question to the exercise" do
        expect { call_endpoint(user, exercise, question) }.to_not change(ExerciseQuestion, :count)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:exercise), create(:question)) }

    it_behaves_like :deny_without_authorization, :post
  end  

  def call_endpoint(user, exercise, question)
    post get_endpoint(exercise, question), headers: header_with_authentication(user)
  end

  def get_endpoint(exercise, question)
    "/api/v1/exercises/#{exercise.id}/questions/#{question.id}"
  end
end
