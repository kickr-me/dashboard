unless ENV['SKIP_MQTT']
  Thread.new do
    MQTT::Client.connect('172.30.1.32', 1883) do |c|
      c.publish('players', Player.all.to_json, true)
      c.subscribe('game/end')
      c.subscribe('game/status')
      c.subscribe('game/start')
      c.subscribe('score/red')
      c.subscribe('score/white')
      c.subscribe('round/current')
      c.subscribe('round/goals')
      c.subscribe('round/end')
      c.get do |topic,message|
        case topic
        when 'game/end'
          p message
          Match.last.update(finished: true)
        when 'game/start'
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
        end
      end
    end
  end
end