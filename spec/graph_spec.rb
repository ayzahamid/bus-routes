require_relative '../src/graph'

require 'rspec'

describe Graph do
  let(:graph) { Graph.new }

  before do
    graph.add_road('A', 'B', 4)
    graph.add_road('B', 'C', 4)
    graph.add_road('C', 'D', 8)
  end

  describe '#add_road' do
    context 'when road exists' do
      it 'adds a road between towns' do
        expect(graph.towns['A'].roads.keys).to include('B')
      end
    end

    context 'when road does not exist' do
      it 'adds a road between towns' do
        graph.add_road('C', 'B', 5)

        expect(graph.towns['C'].roads.keys).not_to include('A')
      end
    end
  end

  describe '#calculate_route_distance' do
    context 'when road exists' do
      it 'calculates the correct route distance' do
        distance = graph.calculate_route_distance('A-B-C')
        expect(distance).to eq(8)
      end
    end

    context 'when road does not exist' do
      it "returns 'NO SUCH ROAD'" do
        distance = graph.calculate_route_distance('D-A')
        expect(distance).to eq('NO SUCH ROAD')
      end
    end
  end

  describe '#count_trips_with_stops' do
    it 'counts trips with maximum stops' do
      trips_count = graph.count_trips_with_stops('A', 'C', max_stops: 3)
      expect(trips_count).to eq(1)
    end

    it 'counts trips with exact stops' do
      trips_count = graph.count_trips_with_stops('A', 'C', exact_stops: 2)
      expect(trips_count).to eq(1)
    end

    it 'raises an error if neither max_stops nor exact_stops is provided' do
      expect { graph.count_trips_with_stops('A', 'C') }.to raise_error(ArgumentError)
    end
  end

  describe '#calculate_shortest_distance' do
    it 'calculates shortest distance between different towns' do
      shortest_distance = graph.calculate_shortest_distance('A', 'C')
      expect(shortest_distance).to eq(8)
    end

    it 'calculates shortest distance to the same town' do
      graph.add_road('D', 'B', 1)
      shortest_distance = graph.calculate_shortest_distance('B', 'B')
      expect(shortest_distance).to eq(13)
    end

    it "returns 'NO SUCH ROAD' for non-existent route" do
      shortest_distance = graph.calculate_shortest_distance('C', 'E')
      expect(shortest_distance).to eq('NO SUCH ROAD')
    end
  end

  describe '#count_trips_within_distance' do
    it 'counts trips within maximum distance' do
      graph.add_road('B', 'D', 2)

      trips_count = graph.count_trips_within_distance('A', 'D', 9)
      expect(trips_count).to eq(1)
    end

    it 'returns 0 if no trips within distance' do
      trips_count = graph.count_trips_within_distance('A', 'D', 7)
      expect(trips_count).to eq(0)
    end
  end
end
