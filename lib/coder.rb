class Coder
  CHOICES = [1, 2, 3, 4, 5, 6]

  attr_reader :combination

  def initialize
    @combination = []
  end

  def choose
    @combination = []
    4.times do |i|
      @combination.push(CHOICES.sample)
    end
  end

  def guess(arr)
    code = []
    4.times do |i|
      char = if @combination.include?(arr[i])
               @combination[i] == arr[i] ? "G" : "Y"
             else
               "R"
             end
      code.push(char)
    end
    code
  end
end
