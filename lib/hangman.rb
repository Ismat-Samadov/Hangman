# REQUIRE YAML LIBRARY FOR SERIALIZATION
require 'yaml'

# DEFINE HANGMAN CLASS
class Hangman
  # INITIALIZE METHOD
  def initialize
    # LOAD DICTIONARY FILE AND STORE WORDS IN AN ARRAY
    @dictionary = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)
    # SELECT A SECRET WORD FROM THE DICTIONARY
    @secret_word = select_secret_word
    # INITIALIZE ARRAY TO STORE CORRECT GUESSES
    @correct_guesses = Array.new(@secret_word.length, '_')
    # INITIALIZE ARRAY TO STORE INCORRECT GUESSES
    @incorrect_guesses = []
    # SET REMAINING GUESSES
    @remaining_guesses = 6
  end

  # METHOD TO SELECT A SECRET WORD FROM THE DICTIONARY
  def select_secret_word
    # SELECT A WORD BETWEEN 5 AND 12 CHARACTERS LONG RANDOMLY
    @dictionary.select { |word| (5..12).cover?(word.length) }.sample.downcase
  end

  # METHOD TO DISPLAY GAME STATUS
  def display_game_status
    # DISPLAY SECRET WORD WITH CORRECT GUESSES
    puts "Secret Word: #{@correct_guesses.join(' ')}"
    # DISPLAY INCORRECT GUESSES
    puts "Incorrect Guesses: #{@incorrect_guesses}"
    # DISPLAY REMAINING GUESSES
    puts "Remaining Guesses: #{@remaining_guesses}"
  end

  # METHOD TO MAKE A GUESS
  def make_guess
    # PROMPT USER TO ENTER A LETTER OR SAVE THE GAME
    puts "Enter a letter (or 'save' to save the game):"
    # GET USER INPUT
    guess = gets.chomp.downcase

    # IF USER CHOOSES TO SAVE THE GAME
    if guess == 'save'
      # SAVE THE GAME AND EXIT
      save_game
      puts "Game saved. Exiting..."
      exit
    # IF USER INPUT IS NOT A SINGLE LETTER
    elsif guess.length != 1 || !guess.match?(/[a-z]/)
      # DISPLAY ERROR MESSAGE
      puts "Invalid input. Please enter a single letter."
    # IF USER INPUT IS A CORRECT GUESS
    elsif @secret_word.include?(guess)
      # UPDATE CORRECT GUESSES
      update_correct_guesses(guess)
      # DISPLAY MESSAGE
      puts "Correct guess!"
    # IF USER INPUT IS AN INCORRECT GUESS
    else
      # UPDATE INCORRECT GUESSES
      update_incorrect_guesses(guess)
      # DISPLAY MESSAGE
      puts "Incorrect guess!"
    end
  end

  # METHOD TO UPDATE CORRECT GUESSES
  def update_correct_guesses(guess)
    # ITERATE THROUGH SECRET WORD
    @secret_word.chars.each_with_index do |letter, index|
      # IF GUESSED LETTER MATCHES A LETTER IN THE SECRET WORD
      @correct_guesses[index] = letter if letter == guess
    end
  end

  # METHOD TO UPDATE INCORRECT GUESSES
  def update_incorrect_guesses(guess)
    # ADD INCORRECT GUESS TO ARRAY
    @incorrect_guesses << guess
    # DECREMENT REMAINING GUESSES
    @remaining_guesses -= 1
  end

  # METHOD TO PLAY THE GAME
  def play_game
    # LOOP UNTIL GAME ENDS
    loop do
      # DISPLAY GAME STATUS
      display_game_status
      # MAKE A GUESS
      make_guess
      # CHECK IF PLAYER WINS
      if @correct_guesses.join == @secret_word
        puts "Congratulations! You've guessed the word: #{@secret_word}"
        break
      # CHECK IF PLAYER LOSES
      elsif @remaining_guesses == 0
        puts "You're out of guesses! The secret word was: #{@secret_word}"
        break
      end
    end
  end

  # METHOD TO SAVE THE GAME
  def save_game
    # CREATE HASH WITH GAME DATA
    game_data = {
      secret_word: @secret_word,
      correct_guesses: @correct_guesses,
      incorrect_guesses: @incorrect_guesses,
      remaining_guesses: @remaining_guesses
    }
    # WRITE GAME DATA TO YAML FILE
    File.open('hangman_save.yaml', 'w') { |file| file.write(game_data.to_yaml) }
  end
end

# METHOD TO LOAD A SAVED GAME
def load_game
  # IF SAVED GAME FILE EXISTS
  if File.exist?('hangman_save.yaml')
    # LOAD GAME DATA FROM YAML FILE
    saved_data = YAML.load_file('hangman_save.yaml')
    # CREATE NEW INSTANCE OF HANGMAN CLASS
    hangman_game = Hangman.new
    # SET INSTANCE VARIABLES BASED ON SAVED GAME DATA
    hangman_game.instance_variable_set(:@secret_word, saved_data[:secret_word])
    hangman_game.instance_variable_set(:@correct_guesses, saved_data[:correct_guesses])
    hangman_game.instance_variable_set(:@incorrect_guesses, saved_data[:incorrect_guesses])
    hangman_game.instance_variable_set(:@remaining_guesses, saved_data[:remaining_guesses])
    # DISPLAY MESSAGE
    puts "Loaded saved game."
    # RETURN hangman_game OBJECT
    return hangman_game
  # IF SAVED GAME FILE DOES NOT EXIST
  else
    # DISPLAY MESSAGE
    puts "No saved game found."
    # RETURN nil
    return nil
  end
end

# MAIN PROGRAM STARTS HERE

# DISPLAY WELCOME MESSAGE
puts "Welcome to Hangman!"
# PROMPT USER TO START A NEW GAME OR LOAD A SAVED GAME
puts "Would you like to start a new game or load a saved game? (new/load)"
# GET USER INPUT
response = gets.chomp.downcase

# CREATE Hangman OBJECT BASED ON USER RESPONSE
hangman_game = case response
              when 'new'
                Hangman.new
              when 'load'
                load_game
              else
                puts "Invalid input. Exiting..."
                exit
              end

# PLAY THE GAME IF hangman_game OBJECT IS NOT nil
hangman_game.play_game if hangman_game
