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
    assignments()
  end

  private

  def assignments()
    if @lexer.match(Token::IDENTIFIER)
      @lexer.advance()
      if @lexer.match(Token::EQUAL)
        expression()
        @lexer.advance()
        if @lexer.match(Token::SEMI)
          assignments()
        else
          abort 'error 3'
        end
      else
        abort 'error 2 '
      end
    else
      abort 'error 1'
    end
  end

  def expression
  end
end

program = Parser.new
program.parse(gets.chomp)

#lexer = Lexer.new(gets)
#while !lexer.match(Token::EOI)
#  puts lexer.advance()
#end

# EOF.
