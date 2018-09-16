FactoryBot.define do
  factory :answer do
    content { 'puts "Hello, world!"' }
    # correct { false }
    user
    programming_language
    team_exercise
    question
  end
end
