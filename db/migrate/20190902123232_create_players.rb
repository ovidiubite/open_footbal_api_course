class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :team
      t.string :name
      t.integer :number
      t.integer :team_id
    end
  end
end
