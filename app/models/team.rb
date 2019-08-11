class Team < ApplicationRecord
  resourcify
  
  belongs_to :user

  has_many :team_exercises
  has_many :exercises, through: :team_exercises
  has_many :team_users
  has_many :users, through: :team_users

  validates_presence_of :name
  validates :password, presence: true, length: { minimum: 6 }
  validates_inclusion_of :active, in: [true, false]

  # Used just to keep the pattern of policies with two arguments 
  # (see ClassRoom::EnrollmentPolicy for further details).
  attr_accessor :received_password
end
