require 'rails_helper'

RSpec.describe ClassRoom::EnrollmentPolicy do
  let(:user) { create(:user) }

  permissions :create? do
    it "denies access if enrollment password is wrong" do
      team = create(:team)
      team.received_password = team.password.reverse

      expect(described_class).not_to permit(user, team)
    end

    it "grants access if enrollment password is right" do
      team = create(:team)
      team.received_password = team.password

      expect(described_class).to permit(user, team)
    end
  end
end
