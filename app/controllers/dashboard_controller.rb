class DashboardController < ApplicationController
    def index
        @last_match = Match.last
        @skill_players = Player.where(inactive: false).select{|p| p.matches.size > 6}.sort_by{|p| p.skill.mean}.last(10)
    end
end