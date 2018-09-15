require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:user) }
  
  it { should have_many(:test_cases) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
