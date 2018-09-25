require 'rails_helper'

RSpec.describe "GET /api/v1/questions/:question_id/test_cases", type: :request do
  context "when authenticated" do
    let(:user) { create(:user) }

    context "when question belongs to the user" do
      before do
        @question = create_user_question_with_test_cases(user)

        create_test_cases_from_another_questions

        call_endpoint(user, @question)
      end
      
      it "returns code 200" do
        expect(response).to have_http_status(:success)
      end
  
      it "returns the test cases from the question" do  
        expect(response.body).to eq(serialize(TestCaseSerializer, @question.test_cases))
      end
    end

    context "when question doesn't belongs to the user" do
      it "returns status 403" do
        question = create(:question)

        call_endpoint(user, question)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:question)) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_user_question_with_test_cases(user)
    question = create(:question, user: user)
    create_list(:test_case, 2, question: question)
    
    question
  end

  def create_test_cases_from_another_questions
    create_list(:test_case, 2)
  end

  def call_endpoint(user, question)    
    get get_endpoint(question), headers: header_with_authentication(user)
  end

  def get_endpoint(question)
    "/api/v1/questions/#{question.id}/test_cases"
  end
end
