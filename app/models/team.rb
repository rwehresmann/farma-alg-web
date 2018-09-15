class Team < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :name
  validates :password, presence: true, length: { minimum: 6 }
  validates_inclusion_of :active, in: [true, false]
end
