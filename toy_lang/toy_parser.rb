#!/usr/bin/ruby
# Parser for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# This file includes the Parser class.
#
# Grammar for toy language with left-recursion removed.
#
# Let e = epsilon, then:
#
# Program       -> Assignment*
# Assignment    -> Identifier = Exp;
# Exp           -> Term ExpPrime
# ExpPrime      -> e | + Term ExpPrime | - Term ExpPrime
# Term          -> Fact TermPrime
# TermPrime     -> e | * Fact TermPrime
# Fact          -> ( Exp ) | - Fact | + Fact | Literal | Identifier
# Identifier    -> Letter [ Letter | Digit ]*
# Letter        -> a | ... | z | A | ... | Z | _
# Literal       -> 0 | NonZeroDigit Digit*
# NonZeroDigit  -> 1 | ... | 9
# Digit         -> 0 | 1 | ... | 9

require_relative 'toy_lexer'

class Parser
  def parse(input)
      @lexer = Lexer.new(input)
      assignments
  end

  private

  def assignments
    if @lexer.cmatch(Token::IDENTIFIER)
      @lexer.advance
      if @lexer.cmatch(Token::EQUAL)
        @lexer.advance
        expression
        if @lexer.cmatch(Token::SEMI)
          if !@lexer.cmatch(Token::EOI)
            assignments
          end
        end
      end
    else
      puts 'Error: ident'
    end
  end

  def expression
    term
    expression_prime
  end

  def expression_prime
  end

  def term
    fact
    term_prime
  end

  def term_prime
  end

  def fact
  end
end

if ARGV.length == 0
  puts "Toy Language Interpreter (v. 0.1)\n\\q to exit.\n\n"
  while true
    print '=>>> '
    break if (input = gets.chomp) == '\\q'
    Parser.new.parse(input)
  end
elsif ARGV.length == 1
  Parser.new.parse(gets(nil))
else
  abort "Usage: #{$PROGRAM_NAME} [program_file]"
end

# EOF.
