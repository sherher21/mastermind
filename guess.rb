class Guess
  attr_accessor :code, :colors
  attr_reader :correct_index, :correct_value  
  def initialize(code)
    @code = code
    @colors = []
    # @correct_index = []
    # @correct_value = []
  end

  def valid_guess?
    @code.length == 4 && @code.all? { |num| num.to_s =~ /^[0-5]$/}
  end

  def convert_to_color
    @color = @code.map { |num| COLORS[num.to_i] }
  end

  def check_guesses
    temp_code = $secret_code.clone    
    @correct_index = []
    @correct_value = []
    @code.each_with_index do |value, index|
      # puts "color guess=#{color} code=#{code[index]} "
      if value == temp_code[index]
        @correct_index << index
        temp_code[index] = "x"
      end      
    end

    @code.each_with_index do |value, index|
      if !@correct_index.include?(index) && temp_code.include?(value)
        @correct_value << temp_code.delete_at(temp_code.find_index(value))
      end
    end
    return [@correct_index.length, @correct_value.length]
  end
end
