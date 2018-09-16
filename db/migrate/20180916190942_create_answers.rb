class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :content, null: false
      t.boolean :correct, null: false, default: false

      t.references :team_exercise, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :programming_language, index: true, foreign_key: true

      t.timestamps
    end
  end
end
