#!/usr/bin/env ruby
# encoding: utf-8

require './ggt'

p = 101
q = 211

n = p*q
m = (p-1)*(q-1)

def calc_l(k, m)
  t = euclid k, m
  if t[0] != 1
    puts "FATAL!"
    exit 1
  else
    l = t[1]
    if l < 0
      l += m
    end
  end

  return l
end

def rsa x, k, n
  x**k % n
end

# Aufgaben
k = 13
p calc_l k, m

k = 19
y = 13749
l = calc_l k, m
p rsa y, l, n

k = 11
x = 4321
p rsa x, k, n


k = 19
y = 16854
l = calc_l k, m
p rsa y, l, n

k = 17
p calc_l k, m

k = 11
x = 1234
p rsa x, k, n
