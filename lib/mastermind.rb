require_relative 'maker_version'
require_relative 'breaker_version'

class Mastermind
  attr_accessor :maker_version, :breaker_version

  def initialize
    self.maker_version = MakerVersion.new
    self.breaker_version = BreakerVersion.new
  end

  def get_game_mode
    puts "Game modes:
  1. The computer will make the secret code and you'll try to break it.
  2. Make the secret code and the computer will try breaking it."

    print 'Choose game mode (1/2): '
    game_mode = gets.chomp

    while game_mode != '1' && game_mode != '2'
      puts 'Invalid game mode. Please enter 1 or 2.'
      print 'Choose game mode (1/2): '
      game_mode = gets.chomp
    end

    game_mode
  end

  def play
    game_mode = get_game_mode

    if game_mode == '1'
      puts '  You chose to be the breaker of the code!'
      breaker_version = BreakerVersion.new
      breaker_version.play
    else
      # puts '  You chose to be the maker of the code!'
      maker_version = MakerVersion.new
      maker_version.play
    end
  end
end
