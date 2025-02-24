require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  # The method returns true if the block never returns false or nil
  def letter_in_point
    @answer.chars.sort.all? { |letter| @point.include?(letter) }
  end

  def score
    @point = params[:point]
    @answer = params[:word]
    point_letters = @point.each_char { |letter| print letter, '' }
    if !letter_in_point
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{point_letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_point && english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end
end
