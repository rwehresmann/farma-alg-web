class TeamExerciseSerializer
  include FastJsonapi::ObjectSerializer
  
  belongs_to :team
  belongs_to :exercise

  attributes :active, :created_at, :updated_at
end
