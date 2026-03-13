require_relative 'lib/game'
require_relative 'lib/serialize'

puts 'Welcome to Hangman!'
puts '1. New Game'
puts '2. Load Game'
print 'Choose an option: '
choice = gets.chomp

if choice == '1'
  game = Game.new
  game.play
elsif choice == '2'
  saved_games = SaveLoad.list_saved_games
  if saved_games.empty?
    puts 'No saved games found.'
  else
    puts 'Saved games:'
    saved_games.each_with_index { |g, i| puts "#{i + 1}. #{g}" }
    print 'Choose a game to load (number): '
    idx = gets.chomp.to_i - 1
    if idx >= 0 && idx < saved_games.size
      game = Game.load(saved_games[idx])
      game.play
    else
      puts 'Invalid choice.'
    end
  end
else
  puts 'Invalid option.'
end
