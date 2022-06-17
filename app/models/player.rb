class Player < ApplicationRecord
    validates :username, presence: true
    has_many :true_skill_ratings

    def self.list
      Player.all.sort_by{|p| p.matches.last&.created_at || 2.years.ago}.reverse.to_json(methods: [:skill, :skill_diff])
    end


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
      true_skill_ratings.last || TrueSkillRating.new(mean: 25.0, deviation: 8.33)
    end

    def skill_diff
      skills = true_skill_ratings.last(2).pluck(:mean)
      skills[1] - skills[0]
    rescue
      0
    end


    def add_skill(mean, deviation, match_id)
      TrueSkillRating.create!(player_id: id, mean: mean, deviation: deviation, match_id: match_id)
    end
end