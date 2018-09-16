require 'rails_helper'

RSpec.describe ProgrammingLanguage, type: :model do
  it { should have_many(:team_exercise_programming_languages) }
  it { should have_many(:team_exercises).through(:team_exercise_programming_languages) }

  it { should validate_presence_of(:name) }
end
