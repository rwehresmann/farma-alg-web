class TestCase < ApplicationRecord
  belongs_to :question
  
  validates_presence_of(
    :input,
    :output,
  )
end
