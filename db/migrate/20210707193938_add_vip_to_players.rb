class AddVipToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :vip, :boolean
  end
end
