class AddMatchToTrueSkillRating < ActiveRecord::Migration[6.0]
  def change
    add_reference :true_skill_ratings, :match, index: true
  end
end
