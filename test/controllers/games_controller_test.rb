require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { player1a_id: @game.player1a_id, player1b_id: @game.player1b_id, player2a_id: @game.player2a_id, player2b_id: @game.player2b_id, team1_goals: @game.team1_goals, team1_rating: @game.team1_rating, team2_goals: @game.team2_goals, team2_rating: @game.team2_rating }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { player1a_id: @game.player1a_id, player1b_id: @game.player1b_id, player2a_id: @game.player2a_id, player2b_id: @game.player2b_id, team1_goals: @game.team1_goals, team1_rating: @game.team1_rating, team2_goals: @game.team2_goals, team2_rating: @game.team2_rating }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
