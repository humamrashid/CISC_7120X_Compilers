#!/usr/bin/ruby
#
# Humam Rashid
# Fall 2019, CISC 7120X
# Answer to question 3, mid-term exam. This implementation
# uses regular expressions to determine token count.

def tokens_num(string)
  literal = /\A0\Z|\A[1-9]\d*\Z/
  identifier = /\A([a-z]|[A-Z]|_)\w*\Z/
  either = /(\A0\Z|\A[1-9]\d*\Z)|(\A([a-z]|[A-Z]|_)\w*\Z)/
  [
    string.split.grep(identifier).length,
    string.split.grep(literal).length,
    string.split.grep_v(either).length
  ]
end

print "Enter a string: "
puts tokens_num(gets.chomp).to_s

# EOF.
