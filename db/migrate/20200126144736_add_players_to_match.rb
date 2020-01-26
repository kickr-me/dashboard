class AddPlayersToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :team_a_front_id, :integer
    add_column :matches, :team_a_back_id, :integer
    add_column :matches, :team_b_front_id, :integer
    add_column :matches, :team_b_back_id, :integer
  end
end
