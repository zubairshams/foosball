class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team_one_id
      t.integer :team_two_id
      t.integer :winning_team_id
      
      t.timestamps null: false
    end
  end
end
