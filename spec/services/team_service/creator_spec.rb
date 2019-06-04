require 'rails_helper'

RSpec.describe TeamService::Creator do
  describe '#call' do
    let!(:user) { create(:user) }

    context 'when data is valid' do
      let(:team_attributes) { attributes_for(:team).merge(user: user) }
  
      it 'creates the team and associate it with the user' do
        team = described_class.new(team_attributes).call
        expect(team.persisted?).to be_truthy
        expect(team.user).to eq(user)
      end

      it 'set the :teacher role for the user to the team' do
        team = described_class.new(team_attributes).call

        expect(user.has_role?(:teacher, team))
      end
    end

    context 'when data isn\'t valid' do
      let(:invalid_team_attributes) { attributes_for(:team) }

      it 'doesn\'t creates the team' do
        expect { described_class.new(invalid_team_attributes).call }.to_not change(Team, :count)
      end

      it 'doesn\'t sets any role' do
        expect { described_class.new(invalid_team_attributes).call }.to_not change(Role, :count)
      end
    end
  end
end
