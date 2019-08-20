require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('A'...'Z').to_a.sample
      @letters << letter
    end
    return @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @message = ""
    @check = []
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = open(url).read
    result = JSON.parse(word_serialized)

    match_letter = @letters.split(" ")

    @word.split("").each do |letter|
      if match_letter.include?(letter)
        @check << true
      else
        @check << false
      end
    end

    if @check.include?(false)
      @message = "Sorry but #{@word} can't be bulit out of #{@letters}"
    elsif @check.all?(true) && result["found"] == true
      @message = "Congratulations! #{@word} is a valid English word!"
    else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
