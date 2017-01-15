class AddMinesToGame < ActiveRecord::Migration
  def change
    add_column :games, :mines, :text
  end
end
