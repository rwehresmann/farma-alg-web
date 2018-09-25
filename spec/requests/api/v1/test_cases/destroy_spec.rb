require 'rails_helper'

RSpec.describe "DELETE /api/v1/test_cases/:id", type: :request do
  context "when authenticated" do 
    let(:user) { create(:user) }
    
    context "when test case belongs to user question" do
      before { @test_case = create_test_case_of_user_question(user) }
      
      context "when test case belongs to a question associated with an exercise" do
        before { create(:exercise, questions: [ @test_case.question ]) }

        context "when the question have only this test case" do
          it "returns status 403" do
            call_endpoint(user, @test_case.id)
  
            expect(response).to have_http_status(:forbidden)
          end
  
          it "doesn't deletes the test case" do
            expect { call_endpoint(user, @test_case.id) }.to_not change(TestCase, :count)          
          end          
        end

        context "when the question have another test case" do
          before { create(:test_case, question: @test_case.question) }

          it "returns code 204" do
            call_endpoint(user, @test_case.id)
  
            expect(response).to have_http_status(:no_content)
          end
  
          it "deletes the test case" do
            expect{ call_endpoint(user, @test_case.id) }.to change(TestCase, :count).by(-1)
          end
        end
      end

      context "when test case doesn't belongs to a question associated with an exercise" do        
        it "returns code 204" do
          call_endpoint(user, @test_case.id)

          expect(response).to have_http_status(:no_content)
        end

        it "deletes the test case" do
          expect{ call_endpoint(user, @test_case.id) }.to change(TestCase, :count).by(-1)
        end
      end
    end
    
    context "when test case doesn't belongs to user question" do
      let!(:test_case) { create(:test_case) }
        
      it "returns status 403" do
        call_endpoint(user, test_case.id)

        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't deletes the test case" do
        expect { call_endpoint(user, test_case.id) }.to_not change(TestCase, :count)          
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :delete
  end  

  def create_test_case_of_user_question(user)
    question = create(:question, user: user)

    create(:test_case, question: question)
  end

  def call_endpoint(user, test_case_id)
    delete get_endpoint(test_case_id), headers: header_with_authentication(user)
  end

  def get_endpoint(test_case_id)
    "/api/v1/test_cases/#{test_case_id}"
  end
end
