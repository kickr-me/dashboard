class Player < ApplicationRecord
    validates :username, presence: true

    def matches
        @matches ||= Match.where("team_a_front_id = ? OR team_a_back_id = ? OR team_b_front_id = ? OR team_b_back_id = ?", id, id, id, id)
    end

    def matches_won
        matches.count do |match|
          match.won_by_player(self)
        end
    end

    def rank
        case matches_won
        when 0..10 then 1
        when 11..20 then 2
        when 21..30 then 3
        when 31..40 then 4
        when 41..50 then 5
        else
          17
        end + 4
    end

    def rank_title
        "Rank #{rank}"
    end

    def rank_url
      "ranks/#{rank}.svg"
    end
end
