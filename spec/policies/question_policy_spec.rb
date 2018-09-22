require 'rails_helper'

RSpec.describe QuestionPolicy do
  permissions :update?, :show?, :destroy? do
    it "denies access if question doesn't belongs to the user" do
      expect(described_class).not_to permit(create(:user), create(:question))
    end

    it "grants access if question belongs to the user" do
      user = create(:user)
      question = create(:question, user: user)

      expect(described_class).to permit(user, question)
    end
  end
end
