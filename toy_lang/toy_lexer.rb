#!/usr/bin/ruby
# Lexer for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# Design partially based on L. Wrobel's 'Math Parser' and
# A. Holub's 'Compiler Design in C' chapter 1.
#
# This file includes the Token and Lexer classes.
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

# Exception type specific to the lexer.
class LexerException < StandardError
end

# Class for representing inividual tokens.
class Token
  attr_accessor :type
  attr_accessor :value

  EOI           = 0
  EQUAL         = 1
  SEMI          = 2
  PLUS          = 3
  MINUS         = 4
  TIMES         = 5
  L_PAREN       = 6
  R_PAREN       = 7
  IDENTIFIER    = 8
  INT_LITERAL   = 9

  def initialize
    @type = nil
    @value = nil
  end
  
  def unknown?
    @type.nil?
  end
end

class Lexer
  def initialize(input)
    @input = input
    @lookahead = nil
  end

  def next_token
    token = Token.new
    @input.lstrip!
    case @input
    when ''
      token.type = Token::EOI
      token.value = $&
    when /\A=/
      token.type = Token::EQUAL
      token.value = $&
    when /\A;/
      token.type = Token::SEMI
      token.value = $&
    when /\A\+/
      token.type = Token::PLUS
      token.value = $&
    when /\A-/
      token.type = Token::MINUS
      token.value = $&
    when /\A\*/
      token.type = Token::TIMES
      token.value = $&
    when /\A\(/
      token.type = Token::L_PAREN
      token.value = $&
    when /\A\)/
      token.type = Token::R_PAREN
      token.value = $&
    when /\A([a-z]|[A-Z]|_)\w*\b/
      token.type = Token::IDENTIFIER
      token.value = $&
    when /(\A0\b)|\A[1-9]\d*\b/
      token.type = Token::INT_LITERAL
      token.value = $&.to_i
    end
    raise LexerException,
      "unknown token #{@input}" if token.unknown?
    @input = $'
    token
  end

  # Checks if the lookahead matches any of the expected
  # tokens. Expected tokens are passed in an array.
  # Returns boolean value indicating if matched.
  #
  # This method is useful when the value of the token is
  # not needed for further procesing; we care only about
  # whether a match was made.
  def match?(expected)
    @lookahead = next_token() if @lookahead.nil?
    expected.include?(@lookahead.type)
  end

  # Checks if the lookahead matches any of the expected
  # tokens. Expected tokens are passed in an array.
  # Returns type of token matched, nil if not matched.
  #
  # This method is useful when the specific type of the
  # token is desirable among several possible matches.
  def match_and_type?(expected)
    match?(expected) ? @lookahead.type : nil
  end

  # Checks if the lookahead matches any of the expected
  # tokens. Expected tokens are passed in an array.
  # Returns value of token matched, nil if not matched.
  #
  # This method is useful when the value of the token is
  # needed for further processing.
  def match_and_value?(expected)
    match?(expected) ? @lookahead.value : nil
  end

  # Checks if the lookahead matches any of the expected
  # tokens. Expected tokens are passed in an array.
  # Returns type and value of token matched in an array, nil
  # if not matched. First return value is type, second is
  # value.
  # 
  # This method is useful when both the type and value of
  # the token maybe needed for further processing.
  def match_and_both?(expected)
    match?(expected) ?
      [@lookahead.type, @lookahead.value] : nil
  end

  # Advances to the next token, safely ignore return value
  # if not needed.
  def advance
    @lookahead = next_token()
  end
end

# EOF.
