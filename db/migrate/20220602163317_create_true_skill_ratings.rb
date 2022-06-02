class CreateTrueSkillRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :true_skill_ratings do |t|
      t.float :mean
      t.float :deviation

      t.timestamps
    end
    add_reference :true_skill_ratings, :player, index: true
  end
end
