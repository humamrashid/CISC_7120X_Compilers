#!/usr/bin/ruby

# An implementation of Trabb Pardo-Knuth algorithm in Ruby.

S = []
11.times { S.push(gets.chomp.to_i) }
S.reverse.each do |e|
  val = Math.sqrt(e.abs) + (5 * e)
  puts (val > 500) ? "#{e}: caused overflow!" : val
end

# EOF.
