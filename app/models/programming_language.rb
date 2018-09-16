class ProgrammingLanguage < ApplicationRecord
  has_many :answers
  has_many :team_exercise_programming_languages
  has_many :team_exercises, through: :team_exercise_programming_languages

  validates_presence_of :name
end
