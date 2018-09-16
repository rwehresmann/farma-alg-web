class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :team_exercise
  belongs_to :question
  belongs_to :programming_language

  validates_presence_of :content
  validates_inclusion_of :correct, in: [true, false]
end
