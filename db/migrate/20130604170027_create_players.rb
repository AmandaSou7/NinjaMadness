class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :alias_name
      t.references :user

      t.timestamps
    end
    add_index :players, :user_id
  end
end
