FactoryBot.define do
  factory :team do
    name { 'Team Cirila' }
    description { nil }
    password { '123456' }
    user
  end
end
