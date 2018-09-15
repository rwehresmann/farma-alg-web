FactoryBot.define do
  factory :question do
    title { 'Sum numbers' }
    description { 'Your program should read two numbers and print the sum of them.' }
    user
  end
end
