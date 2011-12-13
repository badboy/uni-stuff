#!/usr/bin/env ruby
# encoding: utf-8

# Extended euclid
#
# Returns array with 3 elements:
#   First element is the greatest common divisor,
#   Second and third element are λ and μ from the following
#   equation: ggt = λ * a + μ * b
def euclid(a, b)
  return [a, 1, 0] if b == 0

  d1, s1, t1 = euclid b, a % b
  d, s, t = d1, t1, s1-(a/b.to_f).floor*t1

  [d, s, t]
end

def ggT(x, y)
  return y if x == 0

  while y != 0
    if y < x
      x = x-y
    else
      y = y-x
    end
  end

  x
end

def alg(a, b)
  max = [a, b].max
  ggt = ggT(a, b)

  f = false

  λ = 1
  μ = 1
  while (λ < max && !f)
    while (λ*a - μ*b >= ggt)
      if (λ*a - μ*b == ggt)
        print "λ=#{λ}, μ=#{-μ}, "
        puts "d=ggT(#{a}, #{b}) = #{ggt}"
        puts "#{λ}*#{a} + #{-μ}*#{b} = #{λ*a + -μ*b}"
        bd = b/ggt;
        puts "b/d = #{bd}, #{λ} < #{bd} = #{λ<bd}"
        f = true
      end
      μ += 1
    end

    λ += 1
  end
end

alg ARGV[0].to_i, ARGV[1].to_i
