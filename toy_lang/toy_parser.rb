#!/usr/bin/ruby
# Parser for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# Design partially based on L. Wrobel's 'Math Parser' and
# A. Holub's 'Compiler Design in C' chapter 1.
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
#
# In this implementation, some productions are combined
# together in one method. Right-recursions are also replaced
# with loops where appropriate.

require_relative 'toy_lexer'

# Exception type specific to the parser.
class ParserException < StandardError
end

# A parser is an instance of class Parser.
class Parser
  # Parse input on each line.
  def parse(input)
    if input != "\n"
      @lexer = Lexer.new(input)
      assignment
    end
  end

  # Prints out assignment values in order of entry.
  def print_values
    @@symtab.each {|k,v| puts "#{k} = #{v}"}
  end

  # Prints out the last assignment value only.
  def print_last_value
    puts @@symtab.values.last
  end

  protected

  # Symbol table for assignments.
  @@symtab = {}

  # Assignment -> Identifier = Exp;
  def assignment
    reached_eoi = false
    while !reached_eoi do
      expected = [Token::IDENTIFIER]
      ident = @lexer.match_and_value?(expected)
      raise ParserException,
        'Identifier expected!' if ident.nil?
      @lexer.advance
      expected = [Token::EQUAL]
      raise ParserException,
        'Equal sign expected!' if !@lexer.match?(expected)
      @lexer.advance
      @@symtab[ident] = expression()
      expected = [Token::SEMI]
      raise ParserException,
        'Semicolon missing!' if !@lexer.match?(expected)
      @lexer.advance
      expected = [Token::EOI]
      reached_eoi = @lexer.match?(expected)
    end
  end

  # Exp -> Term ExpPrime
  # ExpPrime -> e | + Term ExpPrime | - Term ExpPrime
  # The above productions are combined together in this
  # method.
  def expression
    temp = term()
    add_ops = [Token::PLUS, Token::MINUS]
    while !(token_type =
        @lexer.match_and_type?(add_ops)).nil? do
      @lexer.advance
      temp +=
        (token_type == Token::PLUS) ? term() : -term()
    end
    temp
  end

  # Term -> Fact TermPrime
  # TermPrime -> e | * Fact TermPrime
  # The above productions are combined together in this
  # method.
  def term
    temp = fact()
    mult_ops = [Token::TIMES]
    while !(token_type =
        @lexer.match_and_type?(mult_ops)).nil? do
      @lexer.advance
      temp *= fact()
    end
    temp
  end

  # Fact -> ( Exp ) | - Fact | + Fact | Literal | Identifier
  def fact
    expected = [Token::L_PAREN]
    add_ops = [Token::PLUS, Token::MINUS]
    if @lexer.match?(expected)
      @lexer.advance
      temp = expression()
      expected = [Token::R_PAREN]
      raise ParserException,
        'Mismatched parenthesis!' if !@lexer.match?(expected)
      @lexer.advance
    elsif !(token_type =
        @lexer.match_and_type?(add_ops)).nil?
      @lexer.advance
      temp =
        (token_type == Token::PLUS) ? fact() : -fact()
    else
      expected = [Token::INT_LITERAL, Token::IDENTIFIER]
      both = @lexer.match_and_both?(expected)
      raise ParserException,
        'Literal or identifier expected!' if both.nil?
      token_type, token_value = both[0], both[1]
      temp = (token_type == Token::INT_LITERAL) ?
        token_value : @@symtab[token_value]
      raise ParserException,
        "#{token_value} is uninitialized!" if temp.nil?
      @lexer.advance
    end
    temp
  end
end

# EOF.
