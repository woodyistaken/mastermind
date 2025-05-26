require_relative "guesser"
require_relative "coder"

# methods used when computer play as coder
module CoderMethods
  def play_coder
    round = 0
    won = false
    @coder.choose
    until round >= 12
      guess_arr = ask_for_guess
      won = code_reply(guess_arr)
      break if won

      round += 1
    end
    process_win(won)
  end

  def ask_for_guess
    guess_arr = []
    print "Input your guess:"
    loop do
      guess_arr = convert_str_to_num_arr(gets.chomp)
      break unless guess_arr.include?(-1) || guess_arr.length != 4

      puts "Invalid input"
    end
    guess_arr
  end

  def convert_str_to_num_arr(str)
    str_arr = str.chars
    str_arr.map do |str|
      str.to_i.between?(1, 6) ? str.to_i : -1
    end
  end

  def code_reply(guess_arr)
    code = @coder.guess(guess_arr).join
    return true if code == "GGGG"

    puts "Reply: #{code}"
  end

  def process_win(won)
    if won
      puts "You guessed the correct combination"
    else
      puts "You lost. The correct combination is #{@coder.combination}"
    end
  end
end

# A game class to play the game in
class Game
  include CoderMethods

  def initialize
    @guesser = Guesser.new
    @coder = Coder.new
  end

  def play
    puts "Rules: Guess the code made of 1,2,3,4,5,6"
    puts "G=correct position, Y=number in code, R=number not in code"
    loop do
      puts "Play as guesser or code breaker(g/c)"
      gets.chomp.downcase == "g" ? play_coder : play_guesser
      puts "Continue to play(y/n)"
      break if gets.chomp == "n"
    end
  end

  def play_guesser
  end

  private
end
