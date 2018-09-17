class User < ApplicationRecord
  rolify
  has_secure_password
  
  has_many :questions
  has_many :exercises
  has_many :answers
  has_many :team_users
  has_many :teams, through: :team_users

  validates_presence_of :name, :last_name
  validates :email, presence: true, uniqueness: true
end
