require 'rails_helper'

RSpec.describe "DELETE /api/v1/exercises/:exercise_id/questions/:question_id", type: :request do
  context "when authenticated" do
    let(:user) { create(:user) }
    
    context "when exercise belongs to user" do
      before do
        @question = create(:question)
        @exercise = create(:exercise, user: user, questions: [@question])
      end
      
      it "returns code 204" do
        call_endpoint(user, @exercise, @question)

        expect(response).to have_http_status(:no_content)
      end

      it "removes the exercise's question" do
        expect { 
          call_endpoint(user, @exercise, @question) 
        }.to change(ExerciseQuestion, :count).by(-1)
      end
    end

    context "when exercise doesn't belongs to user" do
      it "returns status 403" do
        call_endpoint(user, create(:exercise), create(:question))

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:exercise), create(:question)) }

    it_behaves_like :deny_without_authorization, :delete
  end  

  def call_endpoint(user, exercise, question)
    delete get_endpoint(exercise, question), headers: header_with_authentication(user)
  end

  def get_endpoint(exercise, question)
    "/api/v1/exercises/#{exercise.id}/questions/#{question.id}"
  end
end
