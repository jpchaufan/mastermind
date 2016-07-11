
class Codebreaker
  attr_reader :code, :rounds_of_guessing, :codelength
  attr_accessor :tries_left, :playing
  COLORS = [ :red, :orange, :yellow, :green, :blue, :indigo, :violet ]
  def initialize codelength=4, rounds=8
    @playing = true
    @tries_left = rounds
  	@codelength = codelength
    @code = generate_code codelength
    @rounds_total = rounds
    @rounds_of_guessing = []
  end

  def store_round guess
    new_round = RoundOfGuessing.new
    new_round.guess = guess
    new_round.report = process_guess guess
    @rounds_of_guessing << new_round
    @tries_left -=1
  end


  def lose? guess
    if @tries_left <= 0 and !win? guess
      @playing = false
      true
    else
      false
    end
  end

  def win? guess
    if guess == @code
      @playing = false
      true
    else 
      false
    end
  end

  private

  def generate_code length
    code = []
    length.times do
      code << COLORS[rand(COLORS.size)]
    end
    code
  end

  def process_guess guess
    hint = []
    guess.each.with_index do |part, i|
      if @code[i] == part
        hint << :hit
      elsif @code.include? part
        hint << :semi_hit
      else
        hint << :miss
      end
    end
    hint
  end
end


class RoundOfGuessing
  attr_accessor :guess, :report
  def initialize 
  end
end











