class Match < ApplicationRecord
    has_many :rounds, dependent: :delete_all

    belongs_to :team_a_front, class_name: 'Player', optional: true
    belongs_to :team_a_back,  class_name: 'Player', optional: true
    belongs_to :team_b_front, class_name: 'Player', optional: true
    belongs_to :team_b_back,  class_name: 'Player', optional: true

    validate :no_duplicate_players

    include Saulabs::TrueSkill

    def title
        "[#{team_a.pluck(:username).to_sentence}] vs. [#{team_b.pluck(:username).to_sentence}]"
    rescue StandardError
        "N/A vs. N/A"
    end

    def team_a
        [team_a_front, team_a_back]
    end

    def team_b
        [team_b_front, team_b_back]
    end

    def players
        [team_a_front_id, team_a_back_id, team_b_front_id, team_b_back_id]
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

        winning_team.include?(player)
    end

    def calculate_skill
        team1 = [Rating.new(team_a.first.skill.mean, team_a.first.skill.deviation),
                  Rating.new(team_a.last.skill.mean, team_a.last.skill.deviation)]
        team2 = [Rating.new(team_b.first.skill.mean, team_b.first.skill.deviation),
                  Rating.new(team_b.last.skill.mean, team_b.last.skill.deviation)]
      if team_a_won?
        graph = FactorGraph.new(team1 => 1, team2 => 2)
      else
        graph = FactorGraph.new(team2 => 1, team1 => 2)
      end

      graph.update_skills

      team_a.first.add_skill(team1.first.mean, team1.first.deviation, id)
      team_a.last.add_skill(team1.last.mean, team1.last.deviation, id)
      team_b.first.add_skill(team2.first.mean, team2.first.deviation, id)
      team_b.last.add_skill(team2.last.mean, team2.last.deviation, id)

    end

    private

    def no_duplicate_players
        players = [team_a_front_id, team_a_back_id, team_b_front_id, team_b_back_id].compact
        p players
        return true if players.size == players.uniq.size

        errors.add(:players, 'players must be uniq')
        false
    end

end
