require 'rails_helper'

RSpec.describe "PUT /api/v1/test_cases/:id", type: :request do
  context "when authenticated" do    
    let(:user) { create(:user) }
    
    context "when test case belongs to user question" do
      before { @test_case = create_test_case_for_user_question(user) }

      context "when data is valid" do
        it "returns status 204" do
          call_endpoint(user, @test_case.id, valid_params)

          expect(response).to have_http_status(:no_content)
        end
  
        it "updates the question" do
          call_endpoint(user, @test_case.id, valid_params)

          expect(@test_case.reload.input).to eq(valid_params[:test_case][:input])
        end
      end

      context "when data is invalid" do
        it "returns status 402" do
          call_endpoint(user, @test_case.id, invalid_params)
        
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "doesn't updates the test case" do
          call_endpoint(user, @test_case.id, invalid_params)

          expect(@test_case.reload.output).to_not eq(invalid_params[:test_case][:output])          
        end
      end
    end

    context "when test case doesn't belongs to user question" do
      let(:test_case) { create(:test_case) }

      it "returns code 403" do
        call_endpoint(user, test_case.id, valid_params)

        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't updates the test case" do
        call_endpoint(user, test_case.id, invalid_params)

        expect(test_case.reload.output).to_not eq(invalid_params[:test_case][:output])          
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :put
  end  

  def create_test_case_for_user_question(user)
    question = create(:question, user: user)
    
    create(:test_case, question: question)
  end

  def call_endpoint(user, test_case_id, params)
    put get_endpoint(test_case_id), params: params, headers: header_with_authentication(user)
  end

  def valid_params
    { test_case: attributes_for(:test_case, input: 'A new test for today') }
  end

  def invalid_params
    { test_case: attributes_for(:test_case, output: nil) }
  end

  def get_endpoint(test_case_id)
    "/api/v1/test_cases/#{test_case_id}"
  end
end
