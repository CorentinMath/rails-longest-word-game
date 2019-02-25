require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    session[:score] ||= 0
    @attempt = params[:word].upcase
    @letters = params[:letters]
    @to_test = @attempt.split('')
    user_serialized = open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    word = JSON.parse(user_serialized)
    @message = "Sorry but #{@attempt} can't be built out of #{@letters}"
    if @to_test.all? { |letter| @to_test.count(letter) <= @letters.count(letter) } && word["found"] == true
      @message = "Congratulations! #{@attempt} is a valid English word"
      session[:score] += @to_test.length
      @score = session[:score]
    elsif @to_test.all? { |letter| @to_test.count(letter) <= @letters.count(letter) }
      @message = "Sorry but #{@attempt} does not seem to be an English word"
      session[:score] += 0
      @score = session[:score] # TO DO not in the dico
      # not in the grid
    else
      session[:score] += 0
      @score = session[:score]
    end
  end
end
