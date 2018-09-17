FactoryBot.define do
  factory :user do
    name { 'Cirila' }
    last_name { 'Fiona Elen Riannon' }
    sequence(:email) { |n| "ciri#{n}@thewitcher.com" }
    password { '123456' }
  end
end
