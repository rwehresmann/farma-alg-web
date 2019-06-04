require 'rails_helper'

RSpec.describe TeamPolicy do
  permissions :update?, :show?, :destroy? do
    it "denies access if team doesn't belongs to the user" do
      expect(described_class).not_to permit(create(:user), create(:team))
    end

    it "grants access if team belongs to the user" do
      user = create(:user)
      team = create(:team, user: user)

      expect(described_class).to permit(user, team)
    end
  end
end
