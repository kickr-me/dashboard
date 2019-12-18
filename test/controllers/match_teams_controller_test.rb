require 'test_helper'

class MatchTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_team = match_teams(:one)
  end

  test "should get index" do
    get match_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_match_team_url
    assert_response :success
  end

  test "should create match_team" do
    assert_difference('MatchTeam.count') do
      post match_teams_url, params: { match_team: {  } }
    end

    assert_redirected_to match_team_url(MatchTeam.last)
  end

  test "should show match_team" do
    get match_team_url(@match_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_team_url(@match_team)
    assert_response :success
  end

  test "should update match_team" do
    patch match_team_url(@match_team), params: { match_team: {  } }
    assert_redirected_to match_team_url(@match_team)
  end

  test "should destroy match_team" do
    assert_difference('MatchTeam.count', -1) do
      delete match_team_url(@match_team)
    end

    assert_redirected_to match_teams_url
  end
end
