class CreateTeamExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :team_exercises do |t|
      t.boolean :active, null: false, default: false
      
      t.references :team, index: true, foreign_key: true
      t.references :exercise, index: true, foreign_key: true
      
      t.index [ :team_id, :exercise_id ], unique: true

      t.timestamps
    end
  end
end
