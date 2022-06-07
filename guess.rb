class Guess
  attr_accessor :code_guess, :color_guess
  
  def initialize(code_guess)
    @code_guess = code_guess
    @color_guess = []
  end

  def valid_guess?
    @code_guess.length == 4 && @code_guess.all? { |num| num =~ /^[1-6]$/}
  end

  def color_guesses
    @color_guess = @code_guess.map { |num| COLORS[num.to_i - 1] }
  end

  def check_guesses(code)
    puts "You got it!" if @color_guess.eql?(code)
  end

end
