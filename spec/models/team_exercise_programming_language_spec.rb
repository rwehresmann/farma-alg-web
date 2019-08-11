require 'rails_helper'

RSpec.describe TeamExerciseProgrammingLanguage, type: :model do
  it { should belong_to(:team_exercise) }
  it { should belong_to(:programming_language) }
  it { should have_one(:team).through(:team_exercise) }

  it "validates uniqueness of team_exercise_id with programming_language_id" do
    allowed_language = create(:team_exercise_programming_language)

    expect { 
      create(
        :team_exercise_programming_language, 
        team_exercise: allowed_language.team_exercise, 
        programming_language: allowed_language.programming_language
      ) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
