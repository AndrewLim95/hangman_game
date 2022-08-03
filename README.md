# hangman_game

Build a simple CLI hangman game 

#1 Generate words
  - download list of words in text file
  - open and readlines from text file
  - randomly generate a word from list
  # to achieve this, I can generate a number from 1-10000, use this number and jump to a specific line in the text file.

  # using read is inefficient because it loads entire file into memory. one way to tackle this is by jumping straight to the index and get line.
  - filter between 5 - 12 characters long
  # either remove the <5 or >13 characters words
  # or regenerate word

#2 Game Logic:
  # 2a Player take guess
    - build a player object
      - takes turn
      - requires input from player
      
  # 2b Computer to print results
    - build a computer object
      - count no. of wrong guesses
      - display solution without the letters
        - check if letter is correct then
        - get the index of correct letters, replace   correct letters with empty word array

      - takes input from player
      - display correct letters guessed
      - match player's guess to solution
      - display results

#3 Allows player to save game
  - build save game object
    - store all variables in an array (serialize)
      JSON/YAML
    - exit the game
    - create a new file
      FILE IO
    - write saved data to file

#4 Load saved game
  - read saved data from file
  - deserialize saved game
  - continue game
 


