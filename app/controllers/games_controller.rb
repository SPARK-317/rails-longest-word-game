require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ("a".."z").to_a
    @letters = []
    10.times { @letters << alphabet[rand(0..25)] }
    p @letters
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    # p @word
    # p @grid

    # check word with API
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data = URI.open(url).read
    json = JSON.parse(data)
    # p json

    if !@word.chars.all? { |letter| @grid.include?(letter) && (@word.count(letter) <= @grid.count(letter)) }
      @result = "cant be built out of grid"
    elsif json["found"] == false
      @result = "not a valid word"
    else
      @result = "SUCCESS!"
    end

  end
end
