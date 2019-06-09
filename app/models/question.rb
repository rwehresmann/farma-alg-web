class Question < ApplicationRecord
  belongs_to :user

  has_many :test_cases
  has_many :answers
  has_many :exercise_questions
  has_many :exercises, through: :exercise_questions

  validates_presence_of :title   
  validates(
    :description, 
    presence: true, 
    length: { minimum: 20 }
  )

  def in_exercises?
    exercises.count > 0
  end
end
