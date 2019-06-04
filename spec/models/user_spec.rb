require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:exercises) }
  it { should have_many(:answers) }
  it { should have_many(:created_teams).class_name('Team') }
  it { should have_many(:team_users) }
  it { should have_many(:teams).through(:team_users) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it do 
    create(:user)
    should validate_uniqueness_of(:email) 
  end
end
