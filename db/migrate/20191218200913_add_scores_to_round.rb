class AddScoresToRound < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :team_a_score, :integer, default: 0
    add_column :rounds, :team_b_score, :integer, default: 0
  end
end
