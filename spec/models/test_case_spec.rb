require 'rails_helper'

RSpec.describe TestCase, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of(:output) }
end
