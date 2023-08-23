require_relative '../src/town'

require 'rspec'

describe Town do
  let(:graph) { Graph.new }

  before do
    graph.add_road('A', 'B', 4)
    graph.add_road('B', 'C', 4)
    graph.add_road('C', 'D', 8)
    graph.add_road('B', 'D', 2)
  end

  describe '#count_trips' do
    it 'counts trips with maximum stops' do
      trips_count = graph.towns['A'].count_trips(graph, 'D', 'A', 0, 3)
      expect(trips_count).to eq(2)
    end

    it 'counts trips with exact stops' do
      trips_count = graph.towns['A'].count_trips(graph, 'C', 'A', 0, nil, 2)
      expect(trips_count).to eq(1)
    end

    it 'does not count trips exceeding max stops' do
      trips_count = graph.towns['A'].count_trips(graph, 'A', 'C', 0, 1)
      expect(trips_count).to eq(0)
    end
  end

  describe '#count_trips_by_distance' do
    it 'counts trips within distance' do
      trips_count = graph.towns['A'].count_trips_by_distance(graph, 'D', 'A', 0, 9)
      expect(trips_count).to eq(1)
    end

    it 'does not count trips exceeding max distance' do
      trips_count = graph.towns['B'].count_trips_by_distance(graph, 'D', 'B', 0, 12)
      expect(trips_count).to eq(1)
    end
  end
end
