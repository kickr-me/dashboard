class Player < ApplicationRecord
    validates :username, presence: true
    has_many :true_skill_ratings

    def matches
        @matches ||= Match.where("team_a_front_id = ? OR team_a_back_id = ? OR team_b_front_id = ? OR team_b_back_id = ?", id, id, id, id)
    end

    def matches_won
        matches.count do |match|
          match.won_by_player(self)
        end
    end

    def rank
      rank = matches_won / 5
      rank > 16 ? 17 : rank + 1
    end

    def rank_title
        "Rank #{rank}"
    end

    def rank_url
      "ranks/#{rank}.svg"
    end

    def skill
      true_skill_ratings.last
    end

    def add_skill(mean, deviation)
      TrueSkillRating.create!(player_id: id, mean: mean, deviation: deviation)
    end
end