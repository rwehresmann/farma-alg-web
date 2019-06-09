require 'rails_helper'

RSpec.describe ExerciseQuestion, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:exercise) }

  it "validates uniqueness of question_id with exercise_id" do
    exercise_question = create(:exercise_question)

    expect { 
      create(:exercise_question, exercise: exercise_question.exercise, question: exercise_question.question) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
