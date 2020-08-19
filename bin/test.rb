#!/usr/bin/env ruby
require 'colorize'
require 'artii'
require_relative '../bin/controller.rb'
require_relative '../bin/player.rb'
require_relative '../bin/interface.rb'

puts '****************************'.blue
puts 'Welcome to Tic Tac Toe game'.blue
puts '****************************'.blue
puts  " "
puts 'Please enter name for player X'.cyan
puts  " "
@player_one = Player.new(gets.chomp)
puts 'Please enter name for player O'.green
puts  " "
@player_two = Player.new(gets.chomp)
puts  " "
puts 'Welcome '.white + @player_one.current_user.cyan + ' your symbol is'.white + ' X'.cyan
puts " "
puts 'Welcome '.white + @player_two.current_user.green + ' your symbol is'.white + ' O'.green

@board = %w[1 2 3 4 5 6 7 8 9]
@counter = 0
def grid(board)
    puts " "
    puts "#{board[0]} | #{board[1]} | #{board[2]}"
    puts "---------"
    puts "#{board[3]} | #{board[4]} | #{board[5]}"
    puts "---------"
    puts "#{board[6]} | #{board[7]} | #{board[8]}"
end

def print_board
    puts grid(@board)
end

puts print_board


def validate (player_move)
    @board.detect{|x| x == player_move.to_s}
end

def try_again
    puts "Enter a valid move"
    valid_move
end

def valid_move 
validate(gets.chomp) || try_again
end

def update_board
    if @counter.even?
        puts "#{@player_one.current_user}".cyan + ' mark your'.white + ' X'.cyan + ' in a number'.white
        @board[valid_move.to_i - 1] = "X".cyan
        @counter += 1
        puts print_board
    else @counter.odd?
        puts "#{@player_two.current_user}".red + ' mark your'.white + ' O'.green + ' in a number'.white
        @board[valid_move.to_i - 1] = "O".green
        @counter += 1
        puts print_board
    end
    
end

WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [2, 4, 6],
    [0, 4, 8]
  ]

def win(x)
    result = false
  WIN_COMBINATIONS.each do |w|
    if (x[w[0]] == x[w[1]]) && (x[w[1]] == x[w[2]])
        result = true
    end   
  end
    result
end


while @counter < 10
    if @counter == 9
        puts " Tie Game Start Again"
        @counter = 10
    elsif !win(@board)
        puts update_board
    elsif win(@board) 
        if @counter.odd?
            puts "#{@player_one.current_user}".cyan + " is the Winner!!".white
            @counter = 10
        else @counter.even?
            puts "#{@player_two.current_user}".green + " is the Winner!!".white
            @counter = 10
        end
    end
end