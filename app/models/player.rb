class Player < ApplicationRecord
    has_and_belongs_to_many :match_teams

    validates :username, presence: true
end
