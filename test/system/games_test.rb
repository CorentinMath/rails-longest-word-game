require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Fill the form with a random word, click the play button, and get a message that the word is not in the grid" do
    visit new_url
    assert test: "not in the grid"
    fill_in "word", with: "Hello"
    click_on "Play"
    assert_text "can't be built out of"
  end

  test "Fill the form with a one-letter consonant word, click play, and get a message it's not a valid English word" do
    visit new_url
    assert test: "not an English word"
    fill_in "word", with: "h"
    click_on "Play"
    assert_text "does not seem to be an English word"
  end

  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
end
