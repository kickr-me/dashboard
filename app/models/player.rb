class Player < ApplicationRecord

    validates :username, presence: true

    def matches
        Match.where("team_a_front_id = ? OR team_a_back_id = ? OR team_b_front_id = ? OR team_b_back_id = ?", id, id, id, id)
    end

    def matches_won
        matches.count do |match|
          match.won_by_player(self)
        end
    end
end
