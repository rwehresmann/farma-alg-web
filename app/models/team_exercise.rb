class TeamExercise < ApplicationRecord
  belongs_to :team
  belongs_to :exercise

  validates_inclusion_of :active, in: [true, false]
  validates :team, uniqueness: { 
    scope: :exercise, message: 'This team already contain this exercise!' 
  }  
end
