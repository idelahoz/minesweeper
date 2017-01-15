class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :warnings
      t.boolean :over
      t.timestamps null: false
    end
  end
end
