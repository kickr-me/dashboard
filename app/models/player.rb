class Player < ApplicationRecord
    has_and_belongs_to_many :match_teams

    validates :username, presence: true

    def matches_won
        matches = match_teams.map do |match_team|
            match_team.matches
        end.flatten

        matches.count do |match|
          match.won_by_player(self)
        end
    end
end
