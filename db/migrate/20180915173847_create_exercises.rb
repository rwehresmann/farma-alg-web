class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :title, null: false
      t.text :description

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
