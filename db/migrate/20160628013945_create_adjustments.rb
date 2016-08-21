class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.integer :rating_id
      t.integer :game_id
      t.float :value
      t.float :margin_of_victory_adjustment

      t.timestamps null: false
    end
  end
end
