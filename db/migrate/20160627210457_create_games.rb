class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.integer :player1_goals
      t.integer :player2_goals
      t.float :player1_rating
      t.float :player2_rating

      t.timestamps null: false
    end
  end
end
