require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    # @letters << ('a'..'z').to_a.sample(1)
  end

  def score
    win(params["word"], params["token"].split(""))
  end

  def win(word, letters)
    filepath = "https://wagon-dictionary.herokuapp.com/#{word}"
    apicall = open(filepath).read
    words = JSON.parse(apicall)

    if included?(word.upcase, letters) == false
      @one = "Sorry but #{word} can't be built out of #{letters}"
    elsif words["found"] == false
      @one = "Sorry but #{word} does not seem to be a valid English word..."
    else
      @one = "Congratulations! #{word} is a valid English word!"
    end
  end

  def included?(word, letters)
  word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
