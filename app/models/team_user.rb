class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :team, uniqueness: { 
    scope: :user, message: 'User already enrolled in this team!' 
  }
  
  validate :teacher_user_validation

  private

  def teacher_user_validation
    errors.add(:user_id, 'is the current teacher of this team.') if user.has_role?(:teacher, team)
  end
end
