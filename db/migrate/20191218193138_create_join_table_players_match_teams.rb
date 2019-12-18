class CreateJoinTablePlayersMatchTeams < ActiveRecord::Migration[6.0]
  def change
    create_join_table :players, :match_teams do |t|
      # t.index [:player_id, :match_team_id]
      # t.index [:match_team_id, :player_id]
    end
  end
end
