require 'rails_helper'

RSpec.describe ProgrammingLanguage, type: :model do
  it { should validate_presence_of(:name) }
end
