class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :match_id
      t.integer :team_one_id
      t.integer :team_two_id
      t.integer :team_one_score,    default: 0
      t.integer :team_two_score,    default: 0
      t.integer :winning_team_id

      t.timestamps null: false
    end
  end
end
