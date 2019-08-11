require 'rails_helper'

RSpec.describe "POST /api/v1/team_exercises/:team_exercise_id/programming_languages/:programming_language_id", type: :request do
  context "when authenticated" do    
    let!(:user) { create(:user) }
    let(:programming_language) { create(:programming_language) }

    context "when team belongs to the user" do
      before do
        @team_exercise = create(:team_exercise, team: create(:team, user: user))
      end
      
      it "returns code 201" do
        call_endpoint(user, @team_exercise, programming_language)

        expect(response).to have_http_status(:created)
      end

      it "adds creates the team_exercise_programming_language" do
        call_endpoint(user, @team_exercise, programming_language)

        expect(@team_exercise.programming_languages).to include(programming_language)
      end
    end

    context "when team_exercise doesn't belongs to the user" do
      let(:team_exercise) { create(:team_exercise) }
      
      it "returns code 422" do
        call_endpoint(user, team_exercise, programming_language)

        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't creates the team_exercise_programming_language" do
        expect { call_endpoint(user, team_exercise, programming_language) }.to_not change(TeamExerciseProgrammingLanguage, :count)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0, 0) }

    it_behaves_like :deny_without_authorization, :post
  end  

  def call_endpoint(user, team_exercise, programming_language)
    post get_endpoint(team_exercise.id, programming_language.id), headers: header_with_authentication(user)
  end

  def get_endpoint(team_exercise_id, programming_language_id)
    "/api/v1/team_exercises/#{team_exercise_id}/programming_languages/#{programming_language_id}"
  end
end
