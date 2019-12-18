require "application_system_test_case"

class MatchTeamsTest < ApplicationSystemTestCase
  setup do
    @match_team = match_teams(:one)
  end

  test "visiting the index" do
    visit match_teams_url
    assert_selector "h1", text: "Match Teams"
  end

  test "creating a Match team" do
    visit match_teams_url
    click_on "New Match Team"

    click_on "Create Match team"

    assert_text "Match team was successfully created"
    click_on "Back"
  end

  test "updating a Match team" do
    visit match_teams_url
    click_on "Edit", match: :first

    click_on "Update Match team"

    assert_text "Match team was successfully updated"
    click_on "Back"
  end

  test "destroying a Match team" do
    visit match_teams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Match team was successfully destroyed"
  end
end
