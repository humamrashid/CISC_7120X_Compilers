#!/usr/bin/ruby

# An implementation of Trabb Pardo-Knuth algorithm in Ruby.

S = []
puts("Enter 11 numbers: ")
11.times { S.push(gets.to_f) }
puts("Result: ")
S.reverse.each do |e|
  val = ->(x) { Math.sqrt(x.abs) + (5 * x) }.call(e)
  puts (val > 500) ? "f(#{e}): caused overflow!" : "f(#{e}) = #{val}"
end

puts("Enter 11 numbers: ")
(S = 11.times.map { gets.to_f }).reverse.each { |e| puts ((val = ->x { Math.sqrt(x.abs) + (5 * x) }.call(e)) > 500) ? "f(#{e}): overflow!" : "f(#{e}) = #{val}" }

# EOF.
