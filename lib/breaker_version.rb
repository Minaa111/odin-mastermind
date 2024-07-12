require 'colorize'
require_relative 'game_extensions'

class BreakerVersion
  using GameExtensions

  attr_accessor :numbers, :secret_code

  def initialize
    self.numbers = %w[1 2 3 4 5 6]
    self.secret_code = []
  end

  def generate_secret_code
    4.times do
      secret_code.push(numbers.sample)
    end
  end

  def game_rules
    puts "Game rules:
  1. You must guess the code, which consists of 4 numbers.
  2. The code is made up of numbers from 1 to 6.
  3. The code can contain duplicate numbers (e.g., 1336 or 1111).
  4. When asked for your guess, enter the four numbers without spaces between them (e.g., 2336).
  5. Each time you enter a guess, you'll get feedback.
    - If a number is #{'yellow'.yellow}, this means that you guessed a number in the code but in the wrong position.
    - If a number is #{'green'.green}, this means that your guess is correct for both the number and the position.
    - If a number is #{'red'.red}, this means that this number isn't in the code.
  6. You have 12 tries to break the code.

  Good luck!"
  end

  def valid_guess?(guess)
    guess = guess.split('')

    return false unless guess.length == 4

    guess.each do |number|
      return false unless numbers.include?(number) || number == ''
    end

    true
  end

  def valid_guess_rules
    puts 'Please enter a valid guess.
  1. It must consist of 4 numbers.
  2. Is made of numbers from 1 to 6.
  3. There is no spaces between the four numbers in your guess.'
  end

  def check_guess(guess)
    guess = guess.split('')
    secret_code_match = Array.new(secret_code.size, false)
    guess_match = Array.new(guess.size, false)

    # First pass: Check for correct positions (green)
    guess.each_with_index do |number, index|
      if secret_code[index] == number
        guess[index] = number.green
        secret_code_match[index] = true
        guess_match[index] = true
      end
    end

    # Second pass: Check for correct numbers in wrong positions (yellow)
    guess.each_with_index do |number, index|
      next if guess_match[index] # Skip already matched

      if secret_code.each_with_index.any? { |secret_number, secret_index| secret_number == number && !secret_code_match[secret_index] }
        guess[index] = number.yellow
        secret_code_match[secret_code.index(number)] = true
      else
        guess[index] = number.red
      end
    end

    puts guess.join
    guess
  end

  def play
    game_rules
    generate_secret_code

    12.times do |try|
      print "Enter your guess (try #{try + 1}): "
      guess = gets.chomp

      until valid_guess?(guess)
        valid_guess_rules

        print "Enter your guess (try #{try + 1}): "
        guess = gets.chomp
      end

      guess = check_guess(guess)

      return puts 'You broke the code. Well done!' if guess.win?
    end

    puts 'You lost. Better luck next time!'
  end
end
