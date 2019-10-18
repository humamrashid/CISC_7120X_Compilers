#!/usr/bin/ruby
#
# Humam Rashid
# Fall 2019, CISC 7120X
# Answer to question 3, mid-term exam. This implementation
# uses regular expressions to determine token count.

def tokens_num2(string)
  ids = lits = others = 0
  string.split.each do |s|
    case s
    when /\A([a-z]|[A-Z]|_)\w*\Z/
      ids += 1
    when /\A0\Z|\A[1-9]\d*\Z/
      lits += 1
    else
      others += 1
    end
  end
  [ids, lits, others]
end

abort "Usage: #{$PROGRAM_NAME} <s1...sN>" unless ARGV.length >= 1
puts tokens_num2(ARGV.join(" ")).to_s

# EOF.
