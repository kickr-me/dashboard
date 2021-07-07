class AddMeritFieldsToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :sash_id, :integer
    add_column :players, :level,   :integer, :default => 0
  end
end
