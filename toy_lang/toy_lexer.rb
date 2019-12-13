#!/usr/bin/ruby
# Lexer for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# Initial design partially based on L. Wrobel's math
# parser.
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
    @ret_prev_token = false
  end

  def next_token
    if @ret_prev_token
      @ret_prev_token = false
      return @prev_token
    end
    token = Token.new
    @input.lstrip!
    case @input
    when ''
      token.type = Token::EOI
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
    when /\A0\Z|\A[1-9]\d*\b/
      token.type = Token::INT_LITERAL
      token.value = $&.to_i
    end
    raise LexerException,
      "unknown token #{@input}" if token.unknown?
    @input = $'
    @prev_token = token
    token
  end

  def get_back
    @ret_prev_token = true
  end

  # Check if the lookahead matches expected token; returns 2
  # values:
  # 1. boolean value indicating if matched.
  # 2. value of token matched, nil if match is false.
  def match?(expected)
    @lookahead = next_token() if @lookahead.nil?
    [expected == @lookahead.type, @lookahead.value]
  end

  # Advances to the next token, ignore return value.
  def advance
    @lookahead = next_token()
  end
end

# EOF.
