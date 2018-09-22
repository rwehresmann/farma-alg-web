require 'rails_helper'

RSpec.describe "PUT /api/v1/questions/:id", type: :request do
  context "when authenticated" do    
    context "when question belongs to user" do
      before do
        @user = create_user_with_question
        @question = @user.questions.first
      end

      context "when data is valid" do
        it "returns status 204" do
          call_endpoint(@user, @question.id, valid_params)

          expect(response).to have_http_status(:no_content)
        end
  
        it "updates the question" do
          call_endpoint(@user, @question.id, valid_params)

          expect(@question.reload.title).to eq(valid_params[:question][:title])
        end
      end

      context "when data is invalid" do
        it "returns status 402" do
          call_endpoint(@user, @question.id, invalid_params)
        
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "doesn't updates the question" do
          call_endpoint(@user, @question.id, invalid_params)

          expect(@question.reload.title).to_not eq(invalid_params[:question][:title])          
        end
      end
    end

    context "when question doesn't belongs to user" do
      it "returns code 403" do
        user = create(:user)
        question = create(:question)

        call_endpoint(user, question.id, valid_params)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :put
  end  

  def create_user_with_question
    user = create(:user)
    
    create(:question, user: user)

    user
  end

  def call_endpoint(user, question_id, params)
    put get_endpoint(question_id), params: params, headers: header_with_authentication(user)
  end

  def valid_params
    { question: { title: 'A new test for today' } }
  end

  def invalid_params
    { question: { title: nil } }
  end

  def get_endpoint(question_id)
    "/api/v1/questions/#{question_id}"
  end
end
