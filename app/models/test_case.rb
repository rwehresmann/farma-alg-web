class TestCase < ApplicationRecord
  belongs_to :question
  
  validates_presence_of :output
end
