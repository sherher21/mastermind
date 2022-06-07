require_relative('guess.rb')
require_relative('computer.rb')

COLORS = ["red", "blue", "green", "yellow", "orange", "violet"]
$secret_code = []
puts <<-MODE
Do you want to create or guess the secret code?"
1. Create secret code
2. Guess secret code
MODE
mode = gets.chomp
until mode == "1" || mode == "2"
  puts "Please enter a valid choice (1 or 2):"
  mode = gets.chomp
end

if mode == "1"
  puts "Enter 4 number for your secret code"
  $secret_code = gets.chomp.split.map { |num| num.to_i } 
else
  4.times {$secret_code.push(rand(0..5))}
end

if mode == "1"
  cpu = Computer.new
  i = 1
  correct_guesses = []
  while i < 13
    puts "Round #{i}"
    guess = Guess.new(cpu.guess_code.clone)
    puts "Computer guessed #{guess.code}"
    correct_guesses = guess.check_guesses

    if correct_guesses[0] == 4
      puts "The computer decoded your secret code in #{i} tries"
      puts "Your secret code is #{$secret_code.to_s}"
      break
    else
      cpu.update_guess(guess.correct_index, guess.correct_value)
    end
    i += 1
  end

  if correct_guesses[0] < 4
    puts "The computer failed to decode your secret code in 12 rounds"
  end
end 

if mode == "2"
  puts <<-RULES
  
  Mastermind

1. Enter 4 numbers for 4 colors in the order they appear in the secret code.
2. Colors may be repeated.
3. Correctly placed colors and correctly guessed colors will be announced
 after each round.

RULES

  color_options = <<-COLORS

    0 = red
    1 = blue
    2 = green
    3 = yellow
    4 = orange
    5 = violet

  Enter your selection:
  COLORS

  i = 1
  correct_guesses = []
  while i < 13
    puts "\nRound #{i}"
    puts color_options
    guess = Guess.new(gets.chomp.split.map { |num| num.to_i })
    until guess.valid_guess?
      puts "Too many or too few guesses. You need exactly 4 guesses."
      puts color_options
      guess.code = gets.chomp.split.map { |num| num.to_i }
    end

    correct_guesses = guess.check_guesses

    if correct_guesses[0] == 4
      puts "You've decoded the secret code in #{i} tries"
      puts "The secret code is #{$secret_code.to_s}"
      break
    else
      puts "Correct places = #{correct_guesses[0]}"
      puts "Correct values = #{correct_guesses[1]}"
    end

    i += 1
  end

  if correct_guesses[0] < 4
  puts "You failed to decode the secret code in 12 rounds"
  end
end
