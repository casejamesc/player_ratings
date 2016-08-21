class Game < ActiveRecord::Base
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player"
  has_many :adjustments, dependent: :destroy

  attr_accessor :player1_points,
                :player2_points,
                :win_factor

  after_create :create_adjustments

  def goal_differential
    player1_goals - player2_goals
  end

  def create_adjustment(args={})
    r1 = (10**(args[:player_rating] / 400))
    r2 = (10**(args[:opponent_rating] / 400))
    regular_adjustment = (32 * (win_factor(args[:player]) - (r1 / (r1 + r2))))
    margin_of_victory_adjustment = margin_of_victory(regular_adjustment)
    adjustments.create(rating: args[:player].rating,
                       value: (regular_adjustment + margin_of_victory_adjustment),
                       margin_of_victory_adjustment: margin_of_victory_adjustment)
  end

  def create_adjustments
    player1_rating = player1.rating.value
    player2_rating = player2.rating.value
    create_adjustment player: player1, player_rating: player1_rating, opponent_rating: player2_rating
    create_adjustment player: player2, player_rating: player2_rating, opponent_rating: player1_rating

    record_ratings
  end

  def margin_of_victory(adjustment_value)
    adjustment_value * goal_differential * 0.1
  end

  def player1_points
    case winner
    when player1
      3
    when player2
      0
    when :tie
      1
    end
  end

  def player2_points
    case winner
    when player1
      0
    when player2
      3
    when :tie
      1
    end
  end

  def record_ratings
    self.update_column(:player1_rating, player1.rating.value)
    self.update_column(:player2_rating, player2.rating.value)
  end

  def winner
    case
    when goal_differential > 0
      player1
    when goal_differential < 0
      player2
    else
      :tie
    end
  end

  def win_factor(player)
    case winner
    when player
      1
    when :tie
      0.5
    else
      0
    end
  end
end
