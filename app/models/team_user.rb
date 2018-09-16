class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :team, uniqueness: { 
    scope: :user, message: 'User already enrolled in this team!' 
  }  
end
