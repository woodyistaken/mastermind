# A class to guesser in mastermind
class Guesser
  def initialize
    @position = Array.new(6) { { position: [0, 1, 2, 3], contains: true, correct: [] } }
    @guess = [-1, -1, -1, -1]
  end

  def guess
    @guess = [-1, -1, -1, -1]
    correct_guess
    different_guess
    return false unless fill_guess

    @guess.join
  end

  def correct_guess
    @position.each_with_index do |info, index|
      num = index + 1
      info[:correct].map do |correct_index|
        @guess[correct_index] = num
        next
      end
    end
  end

  def different_guess
    @position.each_with_index do |info, index|
      num = index + 1
      4.times do |i|
        next unless info[:contains] && @guess[i] == -1 && info[:position].include?(i)

        @guess[i] = num
        break
      end
    end
  end

  def fill_guess
    prev_index = -1
    while fill_index = @guess.index(-1)
      if fill_index == prev_index
        puts "ERROR processing failed"
        reset_guesser
        return false
      end
      @position.each_with_index do |info, index|
        num = index + 1
        @guess[fill_index] = num if info[:contains] && info[:position].include?(fill_index)
      end
      prev_index = fill_index
    end
    true
  end

  def reset_guesser
    @position = Array.new(6) { { position: [0, 1, 2, 3], contains: true, correct: [] } }
    @guess = [-1, -1, -1, -1]
  end

  def process_reply(reply)
    if reply == "GGGG"
      reset_guesser
      return true
    end

    reply.split("").each_with_index do |letter, index|
      if letter == "G"
        @position[@guess[index] - 1][:correct].push(index)
      elsif letter == "R"
        @position[@guess[index] - 1][:contains] = false
      else
        @position[@guess[index] - 1][:position].delete(index)
      end
    end
    false
  end
end
