class Exercise < ApplicationRecord
  belongs_to :user

  has_many :exercise_questions
  has_many :questions, through: :exercise_questions
  has_many :team_exercises
  has_many :teams, through: :team_exercises

  validates_presence_of :title
end
