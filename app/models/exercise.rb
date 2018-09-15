class Exercise < ApplicationRecord
  belongs_to :user

  has_many :question_lists
  has_many :questions, through: :question_lists

  validates_presence_of :title
end
