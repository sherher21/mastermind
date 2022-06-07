require_relative('guess.rb')
COLORS = ["red", "blue", "green", "yellow", "orange", "violet"]
code = []
4.times { code.push(COLORS[rand(0..5)])}
p code

puts <<-RULES
  
    Mastermind

1. Enter 4 numbers for 4 colors in the order they appear in the secret code.
2. Colors may be repeated.
3. Correctly placed colors and correctly guessed colors will be announced
   after each round.

RULES

color_options = <<-COLORS
    1 = red
    2 = blue
    3 = green
    4 = yellow
    5 = orange
    6 = violet
Enter your selection:
COLORS

puts color_options
guess = Guess.new(gets.chomp.split)
until guess.valid_guess?
  puts "Too many or too few guesses. You need exactly 4 guesses."
  puts color_options
  guess.code_guess = gets.chomp.split
end

guess.color_guesses

guess.check_guesses(code)
