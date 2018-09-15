class CreateTestCases < ActiveRecord::Migration[5.2]
  def change
    create_table :test_cases do |t|
      t.text :input
      t.text :output, null: false

      t.references :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
