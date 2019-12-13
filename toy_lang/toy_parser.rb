#!/usr/bin/ruby
# Parser for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# Initial design partially based on L. Wrobel's math
# parser.
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

# Exception type specific to the parser.
class ParserException < StandardError
end

# A parser is an instance of class Parser.
class Parser
  def parse(input)
    if input != "\n"
      @lexer = Lexer.new(input)
      assignments_itr
    end
  end

  # Prints out assignment values in order of entry.
  def print_vals
    @@symtab.each {|k,v| puts "#{k} = #{v}"}
  end

  protected

  # symbol table for assignments.
  @@symtab = {}

  def assignments_itr
    reached_eoi = false
    while !reached_eoi do
      ident = @lexer.match_value?(Token::IDENTIFIER)
      raise ParserException,
        'Identifier expected!' if ident.nil?
      @lexer.advance
      raise ParserException,
        'Equal sign expected!' if !@lexer.match?(Token::EQUAL)
      @lexer.advance
      exp_val = expression()
      @@symtab[ident] = exp_val
      raise ParserException,
        'Semicolon Missing!' if !@lexer.match?(Token::SEMI)
      puts @@symtab
      @lexer.advance
      reached_eoi = @lexer.match?(Token::EOI)
    end
  end

  def expression
    temp1 = term()
    while 
  end

  def expression_prime
  end

  def term
    fact
    term_prime
  end

  def term_prime
    if @lexer.match?(Token::TIMES)
      @lexer.advance
      fact
      term_prime
    end
  end

  def fact
    if @lexer.match?(Token::L_PAREN)
      @lexer.advance
      expression
      if @lexer.match?(Token::R_PAREN)
        @lexer.advance
      end
    elsif @lexer.match?(Token::PLUS) ||
      @lexer.match?(Token::MINUS)
      @lexer.advance
      fact
    elsif @lexer.match?(Token::INT_LITERAL)
      @lexer.advance
    elsif @lexer.match?(Token::IDENTIFIER)
      @lexer.advance
    end
  end
end

# EOF.
