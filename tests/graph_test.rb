# frozen_string_literal: true

require 'test/unit'
require_relative '../src/main'

class GraphTest < Test::Unit::TestCase
  def setup
    @graph = Graph.new
    input_data = [
      ['A', 'B', 5],
      ['B', 'C', 4],
      ['C', 'D', 8],
      ['D', 'C', 8],
      ['D', 'E', 6],
      ['A', 'D', 5],
      ['C', 'E', 2],
      ['E', 'B', 3],
      ['A', 'E', 7],
      ['A', 'F', 10],
      ['F', 'G', 1]
    ]
    input_data.each { |road_data| @graph.add_road(*road_data) }
  end

  def test_calculate_route_distance
    assert_equal(9, @graph.calculate_route_distance('A-B-C'))
    assert_equal('NO SUCH ROAD', @graph.calculate_route_distance('A-E-D'))
  end

  def test_count_trips_with_stops
    assert_equal(2, @graph.count_trips_with_stops('C', 'C', max_stops: 3))
    assert_equal(3, @graph.count_trips_with_stops('A', 'C', exact_stops: 4))
  end

  def test_calculate_shortest_distance
    assert_equal(9, @graph.calculate_shortest_distance('A', 'C'))
    assert_equal(9, @graph.calculate_shortest_distance('B', 'B'))
    assert_equal('NO SUCH ROAD', @graph.calculate_shortest_distance('A', 'K'))
  end

  def test_count_trips_within_distance
    assert_equal(7, @graph.count_trips_within_distance('C', 'C', 30))
    assert_equal(0, @graph.count_trips_within_distance('D', 'E', 5))
    assert_equal(0, @graph.count_trips_within_distance('G', 'A', 5))
    assert_equal(1, @graph.count_trips_within_distance('A', 'G', 15))
    assert_equal(1, @graph.count_trips_within_distance('F', 'G', 2))
  end
end
