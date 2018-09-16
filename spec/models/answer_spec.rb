require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:programming_language) }
  it { should belong_to(:team_exercise) }
  it { should belong_to(:question) }

  it { should validate_presence_of(:content) }
end
