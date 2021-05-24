require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    def score
    @score = {points: params[:points].to_i}
    @letters = params[:letters].split("")
    @user_input = params[:user_guess]
    @user_input_array = @user_input.split("").map{|letter| letter.upcase }
      if (@user_input_array - @letters).empty?
        url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
        user_serialized = URI.open(url).read
        p user_serialized
        response = JSON.parse(user_serialized)
        p response
        if response["found"]
          @score[:message] = "Perfect"
          @score[:points] += 10
        else
          @score[:message] ="That is not a valid word"
          @score[:points] -= 5
        end
      else
        @score[:message] = "not valid letters"
        @score[:points] -= 10
      end
    end
  end
end
