# Class that controls the secret word and users guesses
class Game
  ALLOWED_FALSE_GUESSES = 6

  def initialize
    @game_over = false
    @secret_word = ''
    @false_guesses = 0
    @guessed_letters = []
    set_secret_word
  end

  attr_accessor :secret_word, :guessed_letters, :false_guesses, :game_over

  def set_secret_word
    words = File.readlines('lib/dictionary.txt').map(&:chomp)
    filtered_words = words.select { |word| word.length.between?(5, 12) }
    @secret_word = filtered_words.sample
  end

  # Function to create the word showing only the correct guessed letters, otherwise _
  def display
    word_status = Array.new(secret_word.length, '_').join(' ')
    guessed_letters.each do |letter|
      letter_indexes = find_char_indexes(letter)
      letter_indexes.each { |index| word_status[index * 2] = letter }
    end
    unless word_status.include?('_')
      @game_over = true
      puts 'YOU GUESSED THE WORD!'
    end
    puts word_status
  end

  # Helper function for the display, find the indexes of one char
  def find_char_indexes(char)
    (0...secret_word.length).find_all { |i| secret_word[i, 1] == char }
  end

  def make_guess
    print 'Enter your letter: '
    letter = gets.chomp
    guessed_letters << letter
    if secret_word.include?(letter)
      puts "Correct, '#{letter}' is in the secret word!"
    else
      puts "'#{letter}' is not in the secret word..."
      handle_false_guess
    end
  end

  def handle_false_guess
    @false_guesses += 1
    return unless @false_guesses > ALLOWED_FALSE_GUESSES

    @game_over = true
    puts 'YOU LOST...'
  end

  def play
    until game_over
      puts "Guessed so far: #{guessed_letters}"
      puts "You can make #{ALLOWED_FALSE_GUESSES - false_guesses} more false guesses"
      display
      break if game_over

      make_guess
    end
  end
end
