class Computer
  attr_accessor :guess_code
  def initialize
    @guess_code = []
    4.times {@guess_code.push(rand(0..5))}
  end

  def update_guess(indices, values)
    wrong_indices = [0,1,2,3] - indices
    wrong_indices.each do |index| 
      if values.length < 1
        @guess_code[index] = rand(0..5)
      else
        values.shuffle!
        @guess_code[index] = values[0]
        values.delete_at(0)
      end
    end
  end
end
