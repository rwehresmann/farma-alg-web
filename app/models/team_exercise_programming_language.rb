class TeamExerciseProgrammingLanguage < ApplicationRecord
  belongs_to :team_exercise
  belongs_to :programming_language

  validates :team_exercise, uniqueness: { 
    scope: :programming_language, message: 'This language is already marked as accepted to this exercise.' 
  }  
end
