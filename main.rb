require "unicode_utils/upcase"

require_relative 'game.rb'
require_relative 'result_printer.rb'
require_relative 'word_reader.rb'

current_path = File.dirname(__FILE__)

result_printer = ResultPrinter.new

puts "Игра виселица"
puts "Загадайте слово:"
reader = WordReader.new

slovo = reader.read_from_file(current_path + "/data/words.txt")
slovo_upcase = UnicodeUtils.upcase(slovo)

game = Game.new(slovo_upcase)

while game.status == 0 do
  result_printer.print_status(game)
  game.ask_next_letter
end

result_printer.print_status(game)
