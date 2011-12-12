#!/usr/bin/env ruby
# encoding: utf-8

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
