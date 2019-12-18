class Match < ApplicationRecord
    has_many :rounds

    belongs_to :team_a, class_name: "MatchTeam"
    belongs_to :team_b, class_name: "MatchTeam"
end
