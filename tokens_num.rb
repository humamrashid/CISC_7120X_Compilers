#!/usr/bin/ruby
#
# Humam Rashid
# Fall 2019, CISC 7120X
# Answer to question 3, mid-term exam. This implementation
# uses regular expressions to determine token count.

def tokens_num(string)
  [
    string.split.grep(/\A([a-z]|[A-Z]|_)\w*\Z/).length,
    string.split.grep(/\A0\Z|\A[1-9]\d*\Z/).length,
    string.split.grep_v(/(\A0\Z|\A[1-9]\d*\Z)|(\A([a-z]|[A-Z]|_)\w*\Z)/).length
  ]
end

abort "Usage: #{$PROGRAM_NAME} <s1...sN>" unless ARGV.length >= 1
puts tokens_num(ARGV.join(" ")).to_s

# EOF.
