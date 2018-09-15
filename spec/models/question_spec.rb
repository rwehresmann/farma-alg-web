require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:user) }
  
  it { should have_many(:test_cases) }
  it { should have_many(:question_lists) }
  it { should have_many(:exercises).through(:question_lists) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_least(20) }
end
