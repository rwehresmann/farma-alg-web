require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it do 
    create(:user)
    should validate_uniqueness_of(:email) 
  end
end
