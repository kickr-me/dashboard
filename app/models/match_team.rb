class MatchTeam < ApplicationRecord
    has_and_belongs_to_many :players
    validates :players, presence: true

    def matches
        Match.where("team_a_id = ? OR team_b_id = ?", self.id, self.id)
    end
end
