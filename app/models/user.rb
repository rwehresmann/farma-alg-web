class User < ApplicationRecord
  validates_presence_of :name, :last_name
  validates :email, presence: true, uniqueness: true
end
