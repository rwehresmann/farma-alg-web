require 'rails_helper'

RSpec.describe "GET /api/v1/test_cases/:id", type: :request do
  context "when authenticated" do    
    let(:user) { create(:user) }

    context "when question belongs to the user" do
      before do 
        @test_case = create_test_case_of_user_question(user) 
        call_endpoint(user, @test_case)
      end     
      
      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the test case" do
        expect(response.body).to eq(serialize(TestCaseSerializer, @test_case))
      end
    end

    context "when question doesn't belongs to user" do
      it "returns status 403" do
        test_case = create(:test_case)

        call_endpoint(user, test_case)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:test_case)) }

    it_behaves_like :deny_without_authorization, :get
  end  

  def create_test_case_of_user_question(user)
    question = create(:question, user: user)

    create(:test_case, question: question)
  end

  def call_endpoint(user, test_case)
    get get_endpoint(test_case), headers: header_with_authentication(user)
  end

  def get_endpoint(test_case)
    "/api/v1/test_cases/#{test_case.id}"
  end
end
