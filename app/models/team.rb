class Team < ApplicationRecord
  belongs_to :user

  has_many :team_exercises
  has_many :exercises, through: :team_exercises
  has_many :team_users
  has_many :users, through: :team_users

  validates_presence_of :name
  validates :password, presence: true, length: { minimum: 6 }
  validates_inclusion_of :active, in: [true, false]
end
