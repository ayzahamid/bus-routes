# frozen_string_literal: true

require_relative 'town'

class Graph
  attr_reader :towns

  def initialize
    @towns = {}
  end

  def add_road(source, destination, distance)
    @towns[source] ||= Town.new(source)
    @towns[destination] ||= Town.new(destination)
    @towns[source].add_road(destination, distance.to_i)
  end

  def load_input_data(input_filename)
    File.foreach(input_filename) do |line|
      source, destination, distance = line.split
      add_road(source, destination, distance)
    end
  end

  def calculate_route_distance(route)
    towns = route.split('-')
    total_distance = 0

    (0...(towns.size - 1)).each do |i|
      source = towns[i]
      destination = towns[i + 1]
      return 'NO SUCH ROAD' unless @towns.key?(source) && @towns[source].roads.key?(destination)

      total_distance += @towns[source].roads[destination]
    end

    total_distance
  end

  def count_trips_with_stops(start, end_town, max_stops: nil, exact_stops: nil)
    raise ArgumentError, 'Either max_stops or exact_stops should be provided' if max_stops.nil? && exact_stops.nil?

    towns[start].count_trips(self, end_town, start, 0, max_stops, exact_stops)
  end

  def calculate_shortest_distance(start, target)
    return shortest_cycle(start) if start == target

    distances = dijkstra_algo(start)
    distances[target] || 'NO SUCH ROAD'
  end

  def count_trips_within_distance(start, end_town, max_distance)
    towns[start].count_trips_by_distance(self, end_town, start, 0, max_distance)
  end

  private

  def dijkstra_algo(start)
    distances = initialize_distances(start)
    priority_queue = initialize_priority_queue(start)

    process_priority_queue(priority_queue, distances)

    distances
  end

  def initialize_distances(start)
    distances = {}
    @towns.each_key { |town| distances[town] = Float::INFINITY }
    distances[start] = 0
    distances
  end

  def initialize_priority_queue(start)
    priority_queue = []
    priority_queue << [0, start]
    priority_queue
  end

  def process_priority_queue(priority_queue, distances)
    until priority_queue.empty?
      current_distance, current_node = priority_queue.shift

      next unless distances[current_node] == current_distance

      update_distances_and_queue(current_node, current_distance, priority_queue, distances)
    end
  end

  def update_distances_and_queue(current_node, current_distance, priority_queue, distances)
    @towns[current_node].roads.each do |neighbor, weight|
      distance = current_distance + weight
      if distance < distances[neighbor]
        distances[neighbor] = distance
        priority_queue << [distance, neighbor]
      end
    end
  end

  def shortest_cycle(start)
    min_cycle_distance = Float::INFINITY

    @towns[start].roads.each do |neighbor, weight|
      distances = dijkstra_algo(neighbor)

      if distances[start] && distances[start] != Float::INFINITY
        cycle_distance = distances[start] + weight
        min_cycle_distance = [min_cycle_distance, cycle_distance].min
      end
    end

    min_cycle_distance == Float::INFINITY ? 'NO SUCH ROAD' : min_cycle_distance
  end
end
