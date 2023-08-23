# frozen_string_literal: true

require_relative 'graph'

class Town
  attr_reader :name, :roads

  def initialize(name)
    @name = name
    @roads = {}
  end

  def add_road(neighbor, distance)
    @roads[neighbor] = distance
  end

  def count_trips(graph, start, current, stops, max_stops = nil, exact_stops = nil)
    return 0 if (exact_stops && stops > exact_stops) || (max_stops && stops > max_stops)

    count = 0

    if current == start && stops.positive? && ((exact_stops.nil? && stops <= max_stops) ||
         (max_stops.nil? && stops == exact_stops))
      count += 1
    end

    @roads.each do |neighbor, _|
      count += graph.towns[neighbor].count_trips(graph, start, neighbor, stops + 1, max_stops, exact_stops)
    end

    count
  end

  def count_trips_by_distance(graph, start, current, distance, max_distance)
    return 0 if distance >= max_distance

    count = 0

    count += 1 if current == start && distance.positive?

    @roads.each do |neighbor, road_distance|
      count += graph.towns[neighbor].count_trips_by_distance(graph, start, neighbor, distance + road_distance,
                                                             max_distance)
    end

    count
  end
end
