#!/usr/bin/env ruby
# encoding: utf-8

# © Jan-Erik
# Simple Berechnung des Signums einer Abbildung
# durch Anwendung der Multiplikationsformel.

def r(i)
  (i+0.5).floor
end

def signum(p)
  n = p.keys.size
  res = 1
  1.upto(n-1) do |i|
    (i+1).upto(n) do |j|
      t = (p[i]-p[j]).to_f/(i-j).to_f
      res *= t
    end
  end
  r(res)
end

p_bsp = {
  1 => 2,
  2 => 3,
  3 => 1
}

puts "Signum von p_bsp ist: " + signum(p_bsp).to_s
