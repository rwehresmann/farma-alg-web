class TeamExercise < ApplicationRecord
  belongs_to :team
  belongs_to :exercise
  
  has_many :team_exercise_programming_languages
  has_many :programming_languages, through: :team_exercise_programming_languages

  validates_inclusion_of :active, in: [true, false]
  validates :team, uniqueness: { 
    scope: :exercise, message: 'This team already contain this exercise!' 
  }  
end
