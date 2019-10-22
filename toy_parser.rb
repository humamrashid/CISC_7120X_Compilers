#!/usr/bin/ruby

require_relative 'toy_lexer'

class Parser
  def parse(input)
    @lexer = Lexer.new(input)
  end
end

# EOF.
