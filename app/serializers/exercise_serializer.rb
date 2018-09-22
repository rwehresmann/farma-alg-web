class ExerciseSerializer
  include FastJsonapi::ObjectSerializer
  
  belongs_to :user

  attributes :title, :description, :created_at
end
