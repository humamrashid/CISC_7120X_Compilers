#!/usr/bin/ruby
# Humam Rashid
# Counts number of identifiers, integer literals and other things in a given expression.

def tokens_num(string)
  [
    string.split.grep(/\A([a-z]|[A-Z]|_)\w*\Z/).length,
    string.split.grep(/\A0\Z|\A[1-9]\d*\Z/).length,
    string.split.grep_v(/(\A0\Z|\A[1-9]\d*\Z)|(\A([a-z]|[A-Z]|_)\w*\Z)/).length
  ]
end
print "Enter a string: "
puts tokens_num(gets.chomp).to_s

# EOF.
