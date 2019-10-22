#!/usr/bin/ruby
# Lexer for toy language.
# Humam Rashid
# CISC 7120X, Fall 2019.
#
# This file includes the Token and Lexer classes. This lexer
# uses backtracking.

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
    @ret_prev_token = false
  end

  def next_token()
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
    when /\A;/
      token.type = Token::SEMI
    when /\A\+/
      token.type = Token::PLUS
    when /\A-/
      token.type = Token::MINUS
    when /\A\*/
      token.type = Token::TIMES
    when /\A\(/
      token.type = Token::L_PAREN
    when /\A\)/
      token.type = Token::R_PAREN
    when /\A([a-z]|[A-Z]|_)\w*\b/
      token.type = Token::IDENTIFIER
    when /\A0\Z|\A[1-9]\d*\b/
      token.type = Token::INT_LITERAL
    end
    raise "unknown token #{@input}" if token.unknown?
    @input = $'

    @prev_token = token
    token
  end

  def getback
    @ret_prev_token = true
  end
end

# EOF.
