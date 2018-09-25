require 'rails_helper'

RSpec.describe "POST /api/v1/questions/:question_id/test_cases", type: :request do
  context "when authenticated" do    
    let(:user) { create(:user) }

    context "when question belongs to user" do
      before { @question = create(:question, user: user) }
      
      context "when data is valid" do
        it "returns code 201" do
          call_endpoint(user, @question, valid_params)
  
          expect(response).to have_http_status(:created)
        end
  
        it "creates the test case associated with question" do
          expect { call_endpoint(user, @question, valid_params) }.to change(TestCase, :count).by(1)
          expect(TestCase.last.question).to eq(@question)
        end
      end
  
      context "when data is invalid" do
        it "returns code 422" do
          call_endpoint(user, @question, invalid_params)
  
          expect(response).to have_http_status(:unprocessable_entity)
        end
  
        it "doesn't create the question" do
          expect { call_endpoint(user, @question, invalid_params) }.to_not change(TestCase, :count)
        end
      end
    end

    context "whe question doesn't belongs to user" do
      it "returns status 403" do
        question = create(:question)

        call_endpoint(user, question, valid_params)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:question)) }

    it_behaves_like :deny_without_authorization, :post, { test_case: {} }
  end  

  def invalid_params
    { test_case: attributes_for(:test_case, output: nil) }
  end

  def valid_params
    { test_case: attributes_for(:test_case) }
  end

  def call_endpoint(user, question, params)
    post get_endpoint(question), params: params, headers: header_with_authentication(user)
  end

  def get_endpoint(question)
    "/api/v1/questions/#{question.id}/test_cases"
  end
end
