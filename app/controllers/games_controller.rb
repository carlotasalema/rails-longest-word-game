require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @score = []
    @word = params[:word]
    @letters = params[:letters]
    api = "https://dictionary.lewagon.com/#{@word.downcase}"
    dictionary_serialized = URI.parse(api).read
    if JSON.parse(dictionary_serialized)['found']
      @score << true
    else
      @score << false
    end

    if @word.downcase.chars.all? { |letter| @word.count(letter) <= @letters.count(letter)}
      @score << true
    else
      @score << false
    end

    case @score
    when [true, true]
      @result = "Congratulations! #{@word} is a valid english word!"
    when [true, false]
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    when [false, true]
      @result = "Sorry but #{@word} does not seem to be a valid english word"
    end
  end
end
