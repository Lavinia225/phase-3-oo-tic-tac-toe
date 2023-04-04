require 'pry'

class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize
        @board = [" ", " "," "," "," "," "," "," "," "]
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i() - 1
    end

    def move(index, token = x)
        board[index] = token
    end

    def position_taken? index
        board[index] != " "
    end

    def valid_move? index
        if index.between?(0,8)
            !position_taken?(index)
        end
    end
    
    def turn_count
        board.filter {|space| space == "X" || space == "O"}.length
    end

    def current_player
        if turn_count.even?
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Please select a position 1 - 9"
        input = gets.chomp
        input_translated = input_to_index(input)
        
        if (valid_move?(input_translated))
            move(input_translated, current_player)
            display_board
        else
            puts "The move is invalid, please select a different move."
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |comb|
        if position_taken?(comb[0]) && board[comb[0]] == board[comb[1]] && board[comb[1]] == board[comb[2]]
            return comb
        end
    end
    end

    def full?
        !board.any?(" ")
    end

    def draw?
        if(!won? && full?)
            true
        else
            false
        end
    end

    def over?
        if(won? || draw?)
            true
        end
    end

    def winner
        combo = won?
        if (combo)
            board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
      end
end