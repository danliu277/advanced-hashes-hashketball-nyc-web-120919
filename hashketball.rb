# Write your code here!

def game_hash
  {
    home: { 
      team_name: 'Brooklyn Nets',
      colors: [
        "Black", 
        "White"
      ],
      players: [
        { 
          player_name: 'Alan Anderson',
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1 
        },
        { 
          player_name: 'Reggie Evans',
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        { 
          player_name: 'Brook Lopez',
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        { player_name: 'Mason Plumlee',
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        { player_name: 'Jason Terry',
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ] 
    },
    away: { 
      team_name: 'Charlotte Hornets',
      colors: [
        "Turquoise", 
        "Purple"
      ],
      players: [
        { 
          player_name: 'Jeff Adrien',
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2 
        },
        { 
          player_name: 'Bismack Biyombo',
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        { 
          player_name: 'DeSagna Diop',
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        { 
          player_name: 'Ben Gordon',
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        { 
          player_name: 'Kemba Walker',
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ] 
    }
  }
end

def num_points_scored(name)
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute != :players
        next
      end
      data.each do |player|
        if player[:player_name] == name
          return player[:points] 
        end
      end
    end
  end
end

def shoe_size(name)
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute != :players
        next
      end
      data.each do |player|
        if player[:player_name] == name
          return player[:shoe] 
        end
      end
    end
  end
end

def team_colors(team_name)
  game_hash.each do |place, team|
    if team[:team_name] == team_name
      return game_hash[place][:colors] 
    end
  end
end

def team_names
  data = game_hash.collect do |place, team|
    team[:team_name]
  end
  return data
end

def player_numbers(name)
  result = []
  game_hash.each do |place, team|
    if team[:team_name] != name
      next
    end
    team.each do |attribute, data|
      if attribute != :players
        next
      end
      data.each do |x|
        result.push(x[:number])
      end
    end
  end
  return result
end

def player_stats(name)
  result = {}
  game_hash.collect do |place, team|
    team.each do |attribute, _data|
      if attribute != :players
        next
      end
      game_hash[place][attribute].each do |player|
        if player[:player_name] != name
          next
        end
        result = player.delete_if do |key, value|
          key == :player_name
        end
      end
    end
  end
  return result
end

def big_shoe_rebounds()
  biggest_shoe = 0
  rebounds = 0
  game_hash.each do |team, data|
    data[:players].each do |player|
      if player[:shoe] > biggest_shoe
        biggest_shoe = player[:shoe]
        rebounds = player[:rebounds]
      end
    end
  end
  return rebounds
end

def iterate_through_players_for(name, stat)
  game_hash.each do |team, data|
    data[:players].each do |player|
      if player[:player_name] == name
        return player[stat] 
      end
    end
  end
end

def player_with_most_of(stat)
  name = nil
  player_stat = 0
  game_hash.each do |team, data|
    data[:players].each do |player|
      if player[stat].is_a? String
        if player[stat].length > player_stat
          player_stat = player[stat].length
          name = player[:player_name]
        end
      elsif player[stat] > player_stat
        player_stat = player[stat]
        name = player[:player_name]
      end
    end
  end
  return name
end

def most_points_scored()
  player_with_most_of(:points)
end

def winning_team()
  scores = { 
    'Brooklyn Nets' => 0, 
    'Charlotte Hornets' => 0 
  }
  game_hash.each do |team, data|
    data[:players].each do |player|
      scores[data[:team_name]] += iterate_through_players_for(player[:player_name], :points)
    end
  end
  return scores.max_by { |key, value| value }.first
end

def player_with_longest_name()
  return player_with_most_of(:player_name)
end

def long_name_steals_a_ton?
  return player_with_most_of(:steals) == player_with_most_of(:player_name)
end