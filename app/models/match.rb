class Match < ApplicationRecord
    has_many :rounds, dependent: :delete_all

    belongs_to :team_a, class_name: "MatchTeam", optional: true
    belongs_to :team_b, class_name: "MatchTeam", optional: true

    def title
        "[#{team_a.title}] vs. [#{team_b.title}]"
    rescue StandardError
        "N/A vs. N/A"
    end

    def round_scores
        rounds.map do |round|
            "(#{round.team_a_score}:#{round.team_b_score})"
        end.join(' ')
    end

    def winning_score
        "(#{winning_score_a}:#{winning_score_b})"
    end

    def winning_score_a
        rounds.count(&:team_a_won?)
    end

    def winning_score_b
        rounds.count(&:team_b_won?)
    end

    def team_a_won?
        winning_score_a > winning_score_b
    end

    def team_b_won?
        winning_score_a < winning_score_b
    end

    def won_by_player(player)
        winning_team = if team_a_won? 
            team_a
        elsif team_b_won?
            team_b
        else
          false
        end

        return false unless winning_team
        
        winning_team.players.include?(player)
    end
end
