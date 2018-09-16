require 'rails_helper'

RSpec.describe Team, type: :model do
  it { belong_to(:user) }
  
  it { should have_many(:team_exercises) }
  it { should have_many(:exercises).through(:team_exercises) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_inclusion_of(:active).in_array([true, false]) }
end
