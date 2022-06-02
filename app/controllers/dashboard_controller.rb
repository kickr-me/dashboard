class DashboardController < ApplicationController
    def index
        @last_match = Match.last
        @skill_players = Player.all.select{|p| p.matches.size > 2}.sort_by{|p| p.skill.mean}.last(10)
    end
end