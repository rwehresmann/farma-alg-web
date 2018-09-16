class CreateTeamExerciseProgrammingLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :team_exercise_programming_languages do |t|
      t.references :team_exercise, index: { name: 'index_tepl_on_team_exercise_id' }, foreign_key: true
      t.references :programming_language, index: { name: 'index_tepl_on_programming_language_id' }, foreign_key: true

      t.index [ :team_exercise_id, :programming_language_id ], unique: true, name: 'index_tepl_on_team_exercise_id_and_programming_language_id'

      t.timestamps
    end
  end
end
