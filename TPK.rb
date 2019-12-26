#!/usr/bin/ruby
# An implementation of Trabb Pardo-Knuth algorithm in Ruby. Written purposefully as a one-liner,
# although not the shortest one.

puts("Enter 11 numbers: ") or (S = 11.times.map { gets.to_f }).reverse.each { |e| puts ((val = ->x { Math.sqrt(x.abs) + (5 * x) }.call(e)) > 500) ? "f(#{e}): overflow!" : "f(#{e}) = #{val}" }

# EOF.
