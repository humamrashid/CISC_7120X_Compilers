#!/usr/bin/ruby

require_relative 'ruby_lexer'

lexer = Lexer.new(gets.chomp)

while (c = lexer.lex()).type != Token::EOI
  if c.type == Token::INT_LITERAL
    puts "found int"
  elsif c.type == Token::IDENTIFIER
    puts "found id"
  end
end
