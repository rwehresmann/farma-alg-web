require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:team) }

  it "validates uniqueness of team with user" do
    team_user = create(:team_user)

    expect { 
      create(:team_user, team: team_user.team, user: team_user.user) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates if the user is the teacher of this team" do
    user = create(:user)
    team = TeamService::Creator.new(attributes_for(:team).merge(user: user)).call

    expect { 
      create(:team_user, user: user, team: team) 
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
