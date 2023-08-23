# bus-routes

## Getting Started
1. Unzip the source code
2. Go to the project's directory
3. `git checkout manage_bus_routes`

## Dependencies
```
rvm to install Ruby
```

## Install dependencies
```
rvm install 3.1.2
gem install rspec
```

## Run Project
To run the project please use the following command.
```
ruby src/main.rb
```

## Running tests
To run the tests please use the following commands.
```
rspec spec/
```

```
ruby -I tests -r test/unit -e "Dir.glob('./tests/test_*.rb') { |f| require f }"
```

## Brief Design Explanation

Town Class (Town.rb):
- The Town class characterizes individual towns within the graph.
- Each town retains a name and a collection of roads that link it to other towns.
- This class provides methods to calculate the number of trips based on stops or a specific distance.

Graph Class (Graph.rb):
- The Graph class is responsible for the graph structure, based on their nodes (towns) and their edge (roads).
- It manages the loading of input data from a file to construct the graph.
- Additionally, it implement functionalities such as calculate route distance, counting trips with maximum or exact stops, counting trips that fall within a given distance, and determining the shortest distances between towns using Dijkstra's algorithm.
