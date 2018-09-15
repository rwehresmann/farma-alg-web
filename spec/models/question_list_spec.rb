require 'rails_helper'

RSpec.describe QuestionList, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:exercise) }

  it "validates uniqueness of question_id with exercise_id" do
    question_list = create(:question_list)

    expect { 
      create(:question_list, exercise: question_list.exercise, question: question_list.question) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
