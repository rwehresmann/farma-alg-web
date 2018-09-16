class CreateProgrammingLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :programming_languages do |t|
      t.string :name, null: false, index: true
      t.timestamps
    end
  end
end
