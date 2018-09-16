class Exercise < ApplicationRecord
  belongs_to :user

  has_many :question_lists
  has_many :questions, through: :question_lists
  has_many :team_exercises
  has_many :teams, through: :team_exercises

  validates_presence_of :title
end
