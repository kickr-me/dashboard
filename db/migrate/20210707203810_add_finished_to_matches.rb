class AddFinishedToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :finished, :boolean
  end
end
