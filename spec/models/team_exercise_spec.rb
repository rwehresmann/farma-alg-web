require 'rails_helper'

RSpec.describe TeamExercise, type: :model do
  it { should belong_to(:team) }
  it { should belong_to(:exercise) }

  it { should have_many(:answers) }
  it { should have_many(:team_exercise_programming_languages) }
  it { should have_many(:programming_languages).through(:team_exercise_programming_languages) }

  it "validates uniqueness of team with exercise" do
    team_exercise = create(:team_exercise)

    expect { 
      create(:team_exercise, exercise: team_exercise.exercise, team: team_exercise.team) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
