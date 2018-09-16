require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it { should belong_to :user }
  
  it { should have_many(:question_lists) }
  it { should have_many(:questions).through(:question_lists) }
  it { should have_many(:team_exercises) }
  it { should have_many(:teams).through(:team_exercises) }

  it { should validate_presence_of(:title) }
end
