class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, null: false, default: true
      t.string :password, null: false

      t.references :user, index: true, foreign_key: true
    
      t.timestamps
    end
  end
end
