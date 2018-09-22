require 'rails_helper'

RSpec.describe "DELETE /api/v1/questions/:id", type: :request do
  context "when authenticated" do    
    context "when question belongs to user" do
      before do
        @user = create_user_with_question
        @question = @user.questions.first
      end
      
      it "returns code 204" do
        call_endpoint(@user, @question.id)

        expect(response).to have_http_status(:no_content)
      end

      it "deletes the question" do
        expect { 
          call_endpoint(@user, @question.id) 
        }.to change(Question, :count).by(-1)
      end
    end

    context "when question doesn't belongs to user" do
      it "returns status 403" do
        user = create(:user)
        question = create(:question)

        call_endpoint(user, question.id)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :delete
  end  

  def create_user_with_question
    user = create(:user)
    create(:question, user: user)

    user
  end

  def call_endpoint(user, question_id)
    delete get_endpoint(question_id), headers: header_with_authentication(user)
  end

  def get_endpoint(question_id)
    "/api/v1/questions/#{question_id}"
  end
end
