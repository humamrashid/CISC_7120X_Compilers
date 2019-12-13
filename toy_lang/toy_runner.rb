#!/usr/bin/ruby
#
# Toy Language Runner (running code for parser).
#
# Humam Rashid
# CISC 7120X, Fall 2019.

require_relative 'toy_parser'

parser = Parser.new

if ARGV.length == 0
  puts "* Toy Language Interpreter *\nCTRL-D to quit.\n\n"
  loop do
    begin
      print '=>>> '
      parser.parse(gets)
    rescue Exception
      puts 'Quitting...'
      break
    end
  end
elsif ARGV.length == 1
  File.foreach(ARGV[0]) { |line| parser.parse(line) }
else
  abort "Usage: #{$PROGRAM_NAME} [program_file]"
end

# EOF.
