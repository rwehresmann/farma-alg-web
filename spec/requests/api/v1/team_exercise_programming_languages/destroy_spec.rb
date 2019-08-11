require 'rails_helper'

RSpec.describe "DELETE /api/v1/team_exercise_programming_languages/:id", type: :request do
  context "when authenticated" do
    let!(:user) { create(:user) }
    
    context "when team belongs to the user" do
      before do
        team_exercise = create(:team_exercise, team: create(:team, user: user))
        @team_exercise_programming_language = create(:team_exercise_programming_language, team_exercise: team_exercise)
      end
      
      it "returns code 204" do
        call_endpoint(user, @team_exercise_programming_language)

        expect(response).to have_http_status(:no_content)
      end

      it "deletes the team_exercise_programming_language" do
        expect { 
          call_endpoint(user, @team_exercise_programming_language) 
        }.to change(TeamExerciseProgrammingLanguage, :count).by(-1)
      end
    end

    context "when team doesn't belongs to the user" do
      it "returns status 403" do
        team_exercise_programming_language = create(:team_exercise_programming_language)

        call_endpoint(user, team_exercise_programming_language)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
    
  context 'When unauthenticated' do
    let(:api_endpoint) { get_endpoint(0) }

    it_behaves_like :deny_without_authorization, :delete
  end  

  def call_endpoint(user, team_exercise_programming_language)
    delete get_endpoint(team_exercise_programming_language.id), headers: header_with_authentication(user)
  end

  def get_endpoint(team_exercise_programming_language_id)
    "/api/v1/team_exercise_programming_languages/#{team_exercise_programming_language_id}"
  end
end
