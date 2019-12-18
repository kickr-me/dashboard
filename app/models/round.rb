class Round < ApplicationRecord
  belongs_to :match

  def team_a_won?
    team_a_score > team_b_score
  end

  def team_b_won?
    team_a_score < team_b_score
  end
end
