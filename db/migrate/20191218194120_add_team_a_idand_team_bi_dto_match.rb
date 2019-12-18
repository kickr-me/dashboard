class AddTeamAIdandTeamBiDtoMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :team_a_id, :integer
    add_column :matches, :team_b_id, :integer

  end
end
