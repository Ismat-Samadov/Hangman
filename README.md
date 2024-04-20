# Hangman Game

Welcome to the Hangman Game repository! This project implements a command-line Hangman game in Ruby, where one player plays against the computer.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [How to Play](#how-to-play)
- [Save and Load Game](#save-and-load-game)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Hangman is a classic word guessing game where the player tries to guess a secret word, one letter at a time. The player has a limited number of guesses and loses if they exhaust all their guesses without guessing the word correctly.

This Hangman game implementation offers an interactive command-line interface, allowing players to make guesses, view game status, and save/load games.

## Features

- Randomly selects a secret word from a dictionary file.
- Displays the secret word with correct guesses and incorrect guesses.
- Allows the player to make guesses, one letter at a time.
- Informs the player about correct or incorrect guesses.
- Tracks remaining guesses and ends the game if the player exhausts all guesses.
- Option to save the game and resume later.
- Option to load a saved game and continue from where it was saved.

## Installation

To run the Hangman game locally, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/Ismat-Samadov/Hangman.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Hangman
   ```

3. Ensure you have Ruby installed on your system.

4. Run the main Ruby script to start the game:

   ```bash
   ruby hangman.rb
   ```

## How to Play

1. When the game starts, you will be prompted to choose whether to start a new game or load a saved game.
2. If you choose to start a new game, the game will randomly select a secret word, and you can begin making guesses.
3. Enter a letter as your guess. The game will inform you if the letter is correct or incorrect.
4. Continue making guesses until you either guess the word correctly or run out of guesses.
5. If you choose to save the game, you can resume it later by selecting the "load" option when starting the game.

## Save and Load Game

The Hangman game allows you to save your progress and load it later. Here's how:

- To save the game, enter `save` when prompted to make a guess. This will save the current game state and exit the game.
- To load a saved game, select the "load" option when starting the game. This will load the saved game and allow you to continue from where you left off.

## Dependencies

This project has the following dependencies:

- Ruby: The programming language used to implement the Hangman game.
- YAML: Used for serialization to save and load game state.

## Contributing

Contributions to this project are welcome! If you have any suggestions, bug fixes, or new features to propose, feel free to open an issue or create a pull request.