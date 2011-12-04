#!/usr/bin/env ruby
# encoding: utf-8

class Graph
  attr_accessor :nodes

  def initialize(matrix)
    @nodes = [0]
    matrix.map{|e|e[0,2]}.flatten.max.times do |i|
      @nodes << Node.new(i+1)
    end

    matrix.each do |(kn1, kn2, weight)|
      @nodes[kn1].addNeighbor(@nodes[kn2], weight)
      @nodes[kn2].addNeighbor(@nodes[kn1], weight)
    end
  end
end

class Node
  attr_reader :key
  attr_reader :neighbors

  def initialize key
    @key = key
    @neighbors = {}
  end

  def addNeighbor(neighbor, cost)
    @neighbors[neighbor.key] = cost
  end
end

def dijkstra(graph, start)
  marked = {}
  marked_order = []
  doublePath = false

  distances = []
  graph.nodes.each do |node|
    distances << 1/0.0
  end
  distances[0] = nil
  distances[start] = 0
  parents = [ nil ] * graph.nodes.size

  while marked.size < graph.nodes.size-1
    min_dis = 1/0.0
    cur = nil
    distances.each_with_index do |dis, ind|
      next if ind == 0
      next if marked[ind]

      if dis <= min_dis
        cur = ind
        min_dis = distances[cur]
      end
    end
    cur_node = graph.nodes[cur]

    marked[cur_node.key] = true
    marked_order << cur_node.key

    cur_node.neighbors.each do |neighbor, cost|
      cost = distances[cur_node.key] + cost
      if cost < distances[neighbor]
        distances[neighbor] = cost
        parents[neighbor]   = cur_node
      elsif cost == distances[neighbor]
        doublePath = true
      end
    end
  end

  puts "Mehrere minimale Pfade: #{doublePath}"
  puts "Summe aller Gewichte von #{start}: #{distances[1..-1].inject(:+)}"
  puts "Minimaler Pfad von #{start} nach 5: #{distances[5]}"
  puts "Reihenfolge der Markierung: #{marked_order*","}"
end

# [1,3,4] means: 1<->3 with weight of 4
ma = [
  [1,3,4], [1,6,12], [1,4,1], [1,2,2],
  [2,4,3], [2,7,6], [2,5,7],
  [3,6,11],
  [4,6,9], [4,7,5],
  [2,7,8],
  [6,7,10]
]

g = Graph.new(ma)
dijkstra(g, 3)
