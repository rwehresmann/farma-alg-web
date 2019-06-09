require 'rails_helper'

RSpec.describe ExerciseQuestionPolicy do
  permissions :index?, :create?, :destroy? do
    it "denies access if exercise doesn't belongs to the user" do
      expect(described_class).not_to permit(create(:user), create(:exercise), create(:question))
    end

    it "grants access if exercise belongs to the user" do
      user = create(:user)
      exercise = create(:exercise, user: user)

      expect(described_class).to permit(user, exercise)
    end
  end
end
