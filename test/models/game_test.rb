require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_adjustments_are_created_for_both_players
    player1 = players :anthon
    player2 = players :billy

    game = Game.create player1_id: player1.id, player2_id: player2.id, player1_goals: 3, player2_goals: 1

    refute_nil player1.adjustments.find_by(game: game)
    refute_nil player2.adjustments.find_by(game: game)
  end

  def test_adjustments_are_created_with_values_around_15_for_similarly_ranked_players
    player1 = players :casey
    player2 = players :ian

    game = Game.create player1_id: player1.id, player2_id: player2.id, player1_goals: 3, player2_goals: 1

    assert_in_delta 16.0, player1.adjustments.find_by(game: game).value, 0.1
    assert_in_delta -16.0, player2.adjustments.find_by(game: game).value, 0.1
    binding.pry
  end

  def test_adjustments_are_created_with_values_less_than_15_when_the_stronger_player_wins
    player1 = players :anthon
    player2 = players :billy

    game = Game.create player1_id: player1.id, player2_id: player2.id, player1_goals: 3, player2_goals: 1

    assert_in_delta 7.7, player1.adjustments.find_by(game: game).value, 0.1
    assert_in_delta -7.7, player2.adjustments.find_by(game: game).value, 0.1
  end

  def test_adjustments_are_created_with_values_less_than_15_when_the_weaker_player_wins
    player1 = players :billy
    player2 = players :anthon

    game = Game.create player1_id: player1.id, player2_id: player2.id, player1_goals: 3, player2_goals: 1

    assert_in_delta 24.3, player1.adjustments.find_by(game: game).value, 0.1
    assert_in_delta -24.3, player2.adjustments.find_by(game: game).value, 0.1
  end
end
