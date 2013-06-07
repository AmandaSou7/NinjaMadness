class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :kills
      t.integer :deaths
      t.references :player

      t.timestamps
    end
    add_index :scores, :player_id
  end
end
