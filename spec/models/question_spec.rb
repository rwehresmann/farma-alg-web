require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:user) }
  
  it { should have_many(:test_cases) }
  it { should have_many(:answers) }
  it { should have_many(:exercise_questions) }
  it { should have_many(:exercises).through(:exercise_questions) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_least(20) }

  describe "#in_exercises?" do
    let(:question) { create(:question) }
    
    it "is true when question belongs to an exercise" do
      question.exercises << create(:exercise)

      expect(question.in_exercises?).to be_truthy
    end

    it "is false when question doesn't belongs to any exercise" do
      expect(question.in_exercises?).to be_falsey
    end
  end
end
