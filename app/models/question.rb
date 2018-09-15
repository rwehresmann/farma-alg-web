class Question < ApplicationRecord
  belongs_to :user

  has_many :test_cases

  validates_presence_of(
    :title, 
    :description
  )
end
