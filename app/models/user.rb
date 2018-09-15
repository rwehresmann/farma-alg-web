class User < ApplicationRecord
  has_many :questions
  has_many :exercises
  has_many :teams

  validates_presence_of :name, :last_name
  validates :email, presence: true, uniqueness: true
end
