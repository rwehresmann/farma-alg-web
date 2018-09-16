class Question < ApplicationRecord
  belongs_to :user

  has_many :test_cases
  has_many :answers
  has_many :question_lists
  has_many :exercises, through: :question_lists

  validates_presence_of :title   
  validates(
    :description, 
    presence: true, 
    length: { minimum: 20 }
  )
end
