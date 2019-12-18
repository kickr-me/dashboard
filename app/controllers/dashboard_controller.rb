class DashboardController < ApplicationController
    def index
        @last_match = Match.last
    end
end