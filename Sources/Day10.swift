import Algorithms

struct Day10: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: "").map { Int($0) ?? 99 } // the test data has ".", so ignore it by setting it to 99
    }
  }

  class TopoMap: @unchecked Sendable {
    let endX: Int
    let endY: Int
    var grid: [Point: Node]
    let trailheads: [Point]

    init(entities: [[Int]]) {
      endX = entities.first!.count
      endY = entities.count

      var grid: [Point: Node] = [:]
      var trailheads: [Point] = []

      for y in 0..<endY {
        for x in 0..<endX {
          let p = Point(x: x, y: y)
          let elev = entities[y][x]
          var neighbors: [Point] = []

          if elev == 0 {
            trailheads.append(p)
          }

          if x > 0 {
            let nx = x - 1
            let ny = y
            if entities[ny][nx] == elev + 1 {
              neighbors.append(Point(x: nx, y: ny))
            }
          }
          if y > 0 {
            let nx = x
            let ny = y - 1
            if entities[ny][nx] == elev + 1 {
              neighbors.append(Point(x: x, y: y - 1))
            }
          }
          if x < endX-1 {
            let nx = x + 1
            let ny = y
            if entities[ny][nx] == elev + 1 {
              neighbors.append(Point(x: x + 1, y: y))
            }
          }
          if y < endX-1 {
            let nx = x
            let ny = y + 1
            if entities[ny][nx] == elev + 1 {
              neighbors.append(Point(x: x, y: y + 1))
            }
          }

          grid[p] = Node(point: p, elevation: elev, outNeighborPoints: neighbors)
        }
      }

      self.grid = grid
      self.trailheads = trailheads
    }

    func outNeighbors(of node: Node) -> [Node] {
      node.outNeighborPoints.map { grid[$0]! }
    }

    func destinationsViaPaths(from node: Node) -> [Point] {
      if node.elevation == 9 {
        return [node.point]
      } else {
        return outNeighbors(of: node).map {
          destinationsViaPaths(from: $0)
        }.reduce([], +)
      }
    }

    struct Point: Hashable {
      let x: Int
      let y: Int
    }

    struct Node {
      let point: Point
      let elevation: Int
      let outNeighborPoints: [Point]
    }
  }

  func part1() -> Any {
    let topoMap = TopoMap(entities: entities)
    let destinations = topoMap.trailheads.map {
      topoMap.destinationsViaPaths(from: topoMap.grid[$0]!)
    }
    let destinationCounts = destinations.map {
      let s = Set($0)
//      print(s.count)
      return s.count
    }
    return destinationCounts.reduce(0, +) // 786
  }

  func part2() -> Any {
    let topoMap = TopoMap(entities: entities)
    let destinations = topoMap.trailheads.map {
      topoMap.destinationsViaPaths(from: topoMap.grid[$0]!)
    }
    let destinationCounts = destinations.map {
      $0.count
    }
    return destinationCounts.reduce(0, +) // 1722
  }
}
