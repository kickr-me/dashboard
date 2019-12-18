class CreateMatchTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :match_teams do |t|

      t.timestamps
    end
  end
end
