class User < ApplicationRecord
  has_many :questions

  validates_presence_of :name, :last_name
  validates :email, presence: true, uniqueness: true
end
