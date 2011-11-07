#!/usr/bin/env ruby
# encoding: utf-8

# © Jan-Erik
# Simple Berechnung des Signums einer Abbildung
# durch Anwendung der Multiplikationsformel.
#
# 5 Beispiele (p1-p5) sind gegeben.

p1 = {
  1 => 2,
  2 => 10,
  3 => 6,
  4 => 11,
  5 => 1,
  6 => 9,
  7 => 8,
  8 => 5,
  9 => 4,
  10 => 12,
  11 => 7,
  12 => 3
}

p2 = {
  1  => 5,
  2  => 7,
  3  => 10,
  4  => 2,
  5  => 3,
  6  => 11,
  7  => 12,
  8  => 8,
  9  => 6,
  10 => 4,
  11 => 9,
  12 => 1,
}

p3 = {
  1  => 2,
  2  => 11,
  3  => 8,
  4  => 5,
  5  => 12,
  6  => 3,
  7  => 6,
  8  => 1,
  9  => 7,
  10 => 9,
  11 => 10,
  12 => 4,
}

p4 = {
  1  => 5,
  2  => 4,
  3  => 6,
  4  => 3,
  5  => 11,
  6  => 9,
  7  => 1,
  8  => 10,
  9  => 8,
  10 => 2,
  11 => 12,
  12 => 7,
}

p5 = {
  1  => 11,
  2  => 6,
  3  => 10,
  4  => 3,
  5  => 12,
  6  => 4,
  7  => 5,
  8  => 2,
  9  => 9,
  10 => 1,
  11 => 8,
  12 => 7,
}

p_bsp = {
  1  => 5,
  2  => 8,
  3  => 3,
  4  => 6,
  5  => 2,
  6  => 7,
  7  => 4,
  8  => 1,
  9  => 9,
  10 => 11,
  11 => 10,
}

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

#puts "Signum von p_bsp ist: " + signum(p_bsp).to_s
puts "Signum von p1 ist: " + signum(p1).to_s
puts "Signum von p2 ist: " + signum(p2).to_s
puts "Signum von p3 ist: " + signum(p3).to_s
puts "Signum von p4 ist: " + signum(p4).to_s
puts "Signum von p5 ist: " + signum(p5).to_s
