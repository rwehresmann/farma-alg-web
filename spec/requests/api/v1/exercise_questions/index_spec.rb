require 'rails_helper'

RSpec.describe 'GET /api/v1/exercises/:exercise_id/questions', type: :request do
  context "when authenticated" do
    before do
      @user = create(:user)
      @exercise = create(:exercise, user: @user)
    end

    it "returns code 200" do
      call_endpoint(@user, @exercise)

      expect(response).to have_http_status(:success)
    end

    it "returns the exercise questions" do
      exercise_questions = create_exercise_questions(@user, @exercise)
      create_questions_for_other_exercises

      call_endpoint(@user, @exercise)

      expect(response.body).to eq(serialize(QuestionSerializer, exercise_questions))
    end
  end

  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(create(:exercise)) }

    it_behaves_like :deny_without_authorization, :get
  end  

  private

  def create_exercise_questions(user, exercise)
    questions = create_list(:question, 2, user: user)
    @exercise.questions << questions
    
    questions
  end

  def create_questions_for_other_exercises
    create_list(:exercise_question, 3)
  end

  def call_endpoint(user, exercise)
    get get_endpoint(exercise), headers: header_with_authentication(user)
  end

  def get_endpoint(exercise)
    "/api/v1/exercises/#{exercise.id}/questions"
  end
end
