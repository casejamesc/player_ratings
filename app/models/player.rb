class Player < ActiveRecord::Base

  has_one :rating
  has_many :adjustments, through: :rating

  after_save :create_rating

  def total_games
    player1_games + player2_games
  end

  def player1_games
    Game.where(player1: self).all
  end

  def player2_games
    Game.where(player2: self).all
  end

  def goals_per_game
    return 0 unless total_games.count > 0
    goals = player1_games.map { |game| game.player1_goals } + player2_games.map { |game| game.player2_goals }
    goals.sum.to_f / (total_games.count)
  end

  def points_per_game
    return 0 unless total_games.count > 0
    points = player1_games.map { |game| game.player1_points } + player2_games.map { |game| game.player2_points }
    points.sum.to_f / (total_games.count)
  end

  def ratings_over_time
    player1_games_over_time = player1_games.map{ |game| [game.created_at, game.player1_rating] }
    player2_games_over_time = player2_games.map{ |game| [game.created_at, game.player2_rating] }
    player1_games_over_time + player2_games_over_time
  end

  def record
    games_won = total_games.count { |game| game.winner == self }
    games_drawn = total_games.count { |game| game.winner == :tie }
    games_lost = total_games.count - games_won - games_drawn

    "#{games_won}:#{games_drawn}:#{games_lost}"
  end

  def max_rating
    ratings_over_time.map{ |x| x[1] }.max
  end

  def min_rating
    ratings_over_time.map{ |x| x[1] }.min
  end
end
