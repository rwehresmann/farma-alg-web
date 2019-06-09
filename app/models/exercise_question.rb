class ExerciseQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :exercise

  validates :question, uniqueness: { 
    scope: :exercise, message: 'The question is already associated with this exercise!' 
  }  
end
