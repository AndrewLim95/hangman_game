require 'json'

$file_name = "google-10000-english-no-swears.txt"
$rand_num = rand(9894)

class Game 
 
    attr_accessor :final_arr, :number_of_tries, :game_over, :secret_word, :empty_arr
    def initialize
        puts'Hang Man Game Initialized!'

        @number_of_tries = 8
        @game_over = false
        @secret_word = get_word($file_name,$rand_num)
        @empty_arr = Array.new
        @player_guess = ""
        @final_arr = Array.new
    end
    #Generate secret word
    def get_word(file_name, rand_num)
        File.foreach(file_name).with_index do |line, line_index|
            if line_index == rand_num
                next if line.length < 5 || line.length > 12
                    return line
            end
        end
    end

    def display_empty_word
        (@secret_word.length - 1).times do 
           @empty_arr.push("_ ")
        end
        print @empty_arr
    end

    def secret_word_array
        secret_word_arr = @secret_word.split('')
        secret_word_arr.pop
        return secret_word_arr
    end
    #comparison array
    def modified_array
        modified_arr = secret_word_array.each_with_index.map {|e,index| e == @player_guess }
        return modified_arr
    end

    def win?
        if secret_word_array == @final_arr
            @game_over = true
            puts "you win!"
        end
        return @game_over
    end
    def lose?
        if @number_of_tries == 0
            @game_over = true
            puts "you lose!"
        end
    end

    #Serialize
    def to_json
        JSON.dump({
            :number_of_tries => @number_of_tries,
            :game_over => @game_over,
            :secret_word => @secret_word
        })
    end

    def from_json(string)
        data = JSON.load string
    end
    #Read and write
    def save_game
        fname = "saved_data.txt"
        save_file = File.open(fname, "w")
        save_file.puts to_json
        save_file.close
    end

    def load_game
        file = File.open("saved_data.txt", "r")
        loaded_game = from_json(file)
        file.close
        return loaded_game
    end

    def save?
        puts "save? y/n"
        user_input = gets.chomp
        if user_input == "y"
            save_game
            @game_over = true
        end
    end

    def load?
        puts "Load saved game? y/n"
        user_input = gets.chomp
        if user_input == "y"
            puts deserialize(load_game)
        end
    end

    def deserialize(string)
        @number_of_tries = string["number_of_tries"]
        @game_over = string["game_over"]
        @secret_word = string["secret_word"]
    end
    
    def play
        load?
        while !@game_over
            save?
            puts "Guess a letter."
            @player_guess = gets.chomp
            if secret_word_array.include?(@player_guess)
                modified_array.each_with_index { |e,index|
                    if e == true
                        modified_array[index] = @player_guess
                        @final_arr[index] = @player_guess
                    elsif e == false
                        modified_array[index] = "_"
                    end
                }
                puts "Correct letter, continue."
                print "Word: #{@final_arr}"
            else
                @number_of_tries -= 1
                puts "Wrong guess, you left #{number_of_tries} tries."
                print "Word: #{@final_arr}"
            end
            win?
            lose?
        end    
    end
end

new_game = Game.new

puts new_game.secret_word
puts new_game.display_empty_word
new_game.play
