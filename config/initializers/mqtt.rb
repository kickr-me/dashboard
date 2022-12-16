unless ENV['SKIP_MQTT']
  Thread.abort_on_exception = true
  Thread.new do
    first_game_start = true

    MQTT::Client.connect('172.30.1.32', 1883) do |c|
      c.publish('players', Player.list, true)
      #c.publish('players', Player.all.to_json, true)
      c.subscribe('game/end')
      c.subscribe('game/status')
      c.subscribe('game/start')
      c.subscribe('score/red')
      c.subscribe('score/white')
      c.subscribe('round/current')
      c.subscribe('round/goals')
      c.subscribe('round/end')
      c.subscribe('score/undo-round')
      c.get do |topic,message|
        case topic
        when 'game/end'
          match = Match.last
          if !match.finished
            match.update(finished: true)
            match.calculate_skill
            c.publish('players', Player.list, true)
          end
        when 'game/start'
          if first_game_start
            first_game_start = false
          else
            begin
              payload = JSON.parse(message)
              puts payload
              m = Match.create!(team_b_front_id: payload['red']['attack']['id'],
                            team_b_back_id: payload['red']['defense']['id'],
                            team_a_back_id: payload['white']['defense']['id'],
                            team_a_front_id: payload['white']['attack']['id'])
              Round.create!(match_id: m.id)
            rescue StandardError => error
              puts error
            end
          end
        when 'round/end'
          Round.create!(match: Match.last) unless Match.last&.rounds&.count == 3
        when 'score/red'
          next if Match.last&.finished
          if Match.last&.rounds&.count == 2
            Round.last&.update(team_b_score: message)
          else
            Round.last&.update(team_a_score: message)
          end
        when 'score/white'
          next if Match.last&.finished
          if Match.last&.rounds&.count == 2
            Round.last&.update(team_a_score: message)
          else
            Round.last&.update(team_b_score: message)
          end
        when 'score/undo-round'
          Round.last&.destroy
        end
      end
    end
  end
end
