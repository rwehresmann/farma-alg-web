class CreateTeamUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.index [ :user_id, :team_id ], unique: true

      t.timestamps
    end
  end
end
