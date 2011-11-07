#!/usr/bin/env ruby
# encoding: utf-8

require 'parslet'

class LogicParser < Parslet::Parser
  rule(:space)      { match('\s').repeat(1) }
  rule(:space?)     { space.maybe }

  # Single character rules
  rule(:lparen)     { str('(') >> space? }
  rule(:rparen)     { str(')') >> space? }

  rule(:variable)     { match['A-Z'] >> space? }
  rule(:variable_mod) { not_mod? >> variable }

  rule(:not_mod)    { str('¬') }
  rule(:not_mod?)   { not_mod.maybe }

  rule(:and_mod)    { str('^') >> space? }
  rule(:or_mod)     { str('v') >> space? }
  rule(:implies)    { str('=>') >> space? }
  rule(:if_then)    { str('<=>') >> space? }

  rule(:func) { and_mod | or_mod | implies | if_then }

  rule(:parentheses) { lparen >> expression >> rparen }

  rule(:expression) {
    not_mod? >> (
      ( variable_mod >> func >> expression ) |
      (
       ( lparen >> expression >> rparen ) >>
       (func >> expression).maybe
      ).repeat(1) |
      variable_mod
    )
  }

  root :expression
end

class LogicTransform < Parslet::Transform

end

def parse(str)
  mini = LogicParser.new
  print "Parsing #{str}: "

  p mini.parse(str)
rescue Parslet::ParseFailed => error
  puts error, mini.root.error_tree
end

valid_exp = [
  "A",
  "B",
  "A ^ B",
  "A v B",
  "¬A",
  "(A)",
  "¬(A)",
  "(A ^ B)",
  "¬(A ^ B)",
  "(A ^ ¬B)",
  "(A) v (B)",
  "(A ^ ¬B) v A",
  "(A ^ ¬B) v (A)",
  "(A ^ ¬B) v (¬A ^ B)",
  "(A => (B => C)) => (A => C)",
  "((¬A ^ B) v ¬(A ^ B)) => ¬A",
  "(A ^ (B v C)) <=> ((A ^ B) v (A ^ C))",
  "(A <=> B) v ((A => B) ^ (B => A))",
]

valid_exp.each do |exp|
  parse exp
end
