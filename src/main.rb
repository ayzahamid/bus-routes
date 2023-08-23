# frozen_string_literal: true

require_relative 'town'
require_relative 'graph'

if $PROGRAM_NAME == __FILE__
  graph = Graph.new
  graph.load_input_data('./src/input.txt')

  distance = graph.calculate_route_distance('A-B-C')
  puts "Output #1: #{distance}"

  distance = graph.calculate_route_distance('A-D')
  puts "Output #2: #{distance}"

  distance = graph.calculate_route_distance('A-D-C')
  puts "Output #3: #{distance}"

  distance = graph.calculate_route_distance('A-E-B-C-D')
  puts "Output #4: #{distance}"

  distance = graph.calculate_route_distance('A-E-D')
  puts "Output #5: #{distance}"

  start = 'C'
  end_town = 'C'
  max_stops = 3
  num_trips = graph.count_trips_with_stops(start, end_town, max_stops: max_stops)
  puts "Output #6: #{num_trips}"

  start = 'A'
  end_town = 'C'
  exact_stops = 4
  num_trips = graph.count_trips_with_stops(start, end_town, exact_stops: exact_stops)
  puts "Output #7: #{num_trips}"

  puts "Output #8: #{graph.calculate_shortest_distance('A', 'C')}"
  puts "Output #9: #{graph.calculate_shortest_distance('B', 'B')}"

  num_trips = graph.count_trips_within_distance('C', 'C', 30)
  puts "Output #10: #{num_trips}"
end
