class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, uniq: true, index: true
      t.timestamps
    end
  end
end
