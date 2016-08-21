class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :player_id
      t.float :value, default: 1600

      t.timestamps null: false
    end
  end
end
