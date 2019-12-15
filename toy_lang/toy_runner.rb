#!/usr/bin/ruby
# Toy Language Runner (running code for parser).
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# Design partially based on L. Wrobel's 'Math Parser' and
# A. Holub's 'Compiler Design in C' chapter 1.

require_relative 'toy_parser'

parser = Parser.new

if ARGV.length == 0
  puts "* Toy Language Interpreter *\nCTRL-D to quit.\n\n"
  loop do
    begin
      print '=>>> '
      input = gets
      if input.nil?
        puts 'Quitting...'
        break
      end
      parser.parse(input)
      parser.print_last_value
    rescue StandardError => e
      abort 'Error: ' + e.to_s
    end
  end
elsif ARGV.length == 1
  f = File.new(ARGV[0])
  lines = f.readlines
  begin
    lines.each {|l| parser.parse(l) } if f.eof?
  rescue LexerException, ParserException => e
    abort 'Error: ' + e.to_s
  end
else
  abort "Usage: #{$PROGRAM_NAME} [program_file]"
end
parser.print_values

# EOF.
