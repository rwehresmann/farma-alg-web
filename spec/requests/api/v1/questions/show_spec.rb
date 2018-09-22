require 'rails_helper'

RSpec.describe "GET /api/v1/questions/:id", type: :request do
  context "when authenticated" do    
    context "when question belongs to user" do
      before do
        @user = create_user_with_question
        @question = @user.questions.first
      end

      it "returns code 200" do
        call_endpoint(@user, @question.id)

        expect(response).to have_http_status(:success)
      end

      it "returns the right question" do
        call_endpoint(@user, @question.id)

        expect(response.body).to eq(serialize(QuestionSerializer, @question))  
      end
    end

    context "when question doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        question = create(:question)

        call_endpoint(user, question.id)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_with_question
    user = create(:user)
    create(:question, user: user)

    user
  end

  def call_endpoint(user, question_id)
    get get_endpoint(question_id), headers: header_with_authentication(user)
  end

  def get_endpoint(question_id)
    "/api/v1/questions/#{question_id}"
  end
end
