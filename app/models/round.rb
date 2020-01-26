class Round < ApplicationRecord
  belongs_to :match

  validates :team_a_score, presence: true
  validates :team_b_score, presence: true

  def team_a_won?
    team_a_score > team_b_score
  end

  def team_b_won?
    team_a_score < team_b_score
  end

  def draw?
    team_a_score == team_b_score
  end
end
