require 'yaml'

class Hangman
  def initialize
    @dictionary = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)
    @secret_word = select_secret_word
    @correct_guesses = Array.new(@secret_word.length, '_')
    @incorrect_guesses = []
    @remaining_guesses = 6
  end

  def select_secret_word
    @dictionary.select { |word| (5..12).cover?(word.length) }.sample.downcase
  end

  def display_game_status
    puts "Secret Word: #{@correct_guesses.join(' ')}"
    puts "Incorrect Guesses: #{@incorrect_guesses}"
    puts "Remaining Guesses: #{@remaining_guesses}"
  end

  def make_guess
    puts "Enter a letter (or 'save' to save the game):"
    guess = gets.chomp.downcase

    if guess == 'save'
      save_game
      puts "Game saved. Exiting..."
      exit
    elsif guess.length != 1 || !guess.match?(/[a-z]/)
      puts "Invalid input. Please enter a single letter."
    elsif @secret_word.include?(guess)
      update_correct_guesses(guess)
      puts "Correct guess!"
    else
      update_incorrect_guesses(guess)
      puts "Incorrect guess!"
    end
  end

  def update_correct_guesses(guess)
    @secret_word.chars.each_with_index do |letter, index|
      @correct_guesses[index] = letter if letter == guess
    end
  end

  def update_incorrect_guesses(guess)
    @incorrect_guesses << guess
    @remaining_guesses -= 1
  end

  def play_game
    loop do
      display_game_status
      make_guess
      if @correct_guesses.join == @secret_word
        puts "Congratulations! You've guessed the word: #{@secret_word}"
        break
      elsif @remaining_guesses == 0
        puts "You're out of guesses! The secret word was: #{@secret_word}"
        break
      end
    end
  end

  def save_game
    game_data = {
      secret_word: @secret_word,
      correct_guesses: @correct_guesses,
      incorrect_guesses: @incorrect_guesses,
      remaining_guesses: @remaining_guesses
    }
    File.open('hangman_save.yaml', 'w') { |file| file.write(game_data.to_yaml) }
  end
end

def load_game
  if File.exist?('hangman_save.yaml')
    saved_data = YAML.load_file('hangman_save.yaml')
    hangman_game = Hangman.new
    hangman_game.instance_variable_set(:@secret_word, saved_data[:secret_word])
    hangman_game.instance_variable_set(:@correct_guesses, saved_data[:correct_guesses])
    hangman_game.instance_variable_set(:@incorrect_guesses, saved_data[:incorrect_guesses])
    hangman_game.instance_variable_set(:@remaining_guesses, saved_data[:remaining_guesses])
    puts "Loaded saved game."
    return hangman_game
  else
    puts "No saved game found."
    return nil
  end
end

puts "Welcome to Hangman!"
puts "Would you like to start a new game or load a saved game? (new/load)"
response = gets.chomp.downcase

hangman_game = case response
              when 'new'
                Hangman.new
              when 'load'
                load_game
              else
                puts "Invalid input. Exiting..."
                exit
              end

hangman_game.play_game if hangman_game
