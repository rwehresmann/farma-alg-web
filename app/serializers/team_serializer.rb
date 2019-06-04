class TeamSerializer
  include FastJsonapi::ObjectSerializer
  
  belongs_to :user

  attributes :name, :description, :created_at
end
