class CreateQuestionLists < ActiveRecord::Migration[5.2]
  def change
    create_table :question_lists do |t|
      t.references :question, index: true, foreign_key: true
      t.references :exercise, index: true, foreign_key: true

      t.index [ :question_id, :exercise_id ], unique: true

      t.timestamps
    end
  end
end
