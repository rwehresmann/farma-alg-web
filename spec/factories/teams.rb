FactoryBot.define do
  factory :team do
    name { 'Team Cirila' }
    description { nil }
    password { '123456' }
    user

    after(:create) do |team|
      team.user.add_role(:teacher, team)
    end
  end
end
