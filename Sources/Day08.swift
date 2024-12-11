import Algorithms

struct Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  var antennaMap: AntennaMap

  init(data: String) {
    self.data = data
    self.antennaMap = AntennaMap(data: data)
  }

  class AntennaMap: @unchecked Sendable {
    typealias Coordinate = DictGrid<Antenna>.Coordinate

    let grid: DictGrid<Antenna>
    var coordinatesByCharacter: [String: [Coordinate]]

    struct Antenna {
      let character: String
    }

    init(data: String) {
      let elements = data.split(separator: "\n").map {
        $0.split(separator: "").map(String.init)
      }

      let maxPoint = Coordinate(x: elements.first!.count-1, y: elements.count-1)
      var grid:[Coordinate: Antenna] = [:]
      var coordByChar:[String: [Coordinate]] = [:]

      for y in elements.indices {
        for x in elements[y].indices {
          if elements[y][x] == "." { continue }
          let c = Coordinate(x: x, y: y)
          let a = Antenna(character: elements[y][x])
          grid[c] = a
          coordByChar[a.character, default: []].append(c)
        }
      }

      self.grid = DictGrid(grid: grid, maxPoint: maxPoint)
      self.coordinatesByCharacter = coordByChar
    }

    func antinodesForPair(a: Coordinate, b: Coordinate) -> [Coordinate] {
      let xDiff = abs(a.x - b.x)
      let yDiff = abs(a.y - b.y)
//      print("diff is \(xDiff),\(yDiff)")

      let cx, cy, dx, dy: Int

      if a.x <= b.x {
        cx = a.x - xDiff
        dx = b.x + xDiff
      } else {
        cx = a.x + xDiff
        dx = b.x - xDiff
      }

      if a.y <= b.y {
        cy = a.y - yDiff
        dy = b.y + yDiff
      } else {
        cy = a.y + yDiff
        dy = b.y - yDiff
      }

      return [Coordinate(x: cx, y: cy), Coordinate(x: dx, y: dy)]
    }

    func lineOfAntinodesForPair(a: Coordinate, b: Coordinate) -> [Coordinate] {
      let xDiff = a.x - b.x
      let yDiff = a.y - b.y

      var antinodes: [Coordinate] = []
      // start at a
      var x = a.x
      var y = a.y

      // keep subtracting the diff until we're out of bounds
      while inBounds(coordinate: Coordinate(x: x, y: y)) {
        antinodes.append(Coordinate(x: x, y: y))
        x -= xDiff
        y -= yDiff
      }
      // restart at a
      x = a.x
      y = a.y
      // keep adding the diff until we're out of bounds
      while inBounds(coordinate: Coordinate(x: x, y: y)) {
        antinodes.append(Coordinate(x: x, y: y))
        x += xDiff
        y += yDiff
      }

      return antinodes
    }

    func pairsForAntenna(character: String) -> [[Coordinate]] {
      let coords = coordinatesByCharacter[character]!
      return Array(coords.combinations(ofCount: 2))
    }

    func inBounds(coordinate: Coordinate) -> Bool {
      (0...grid.maxPoint.x).contains(coordinate.x) && (0...grid.maxPoint.y).contains(coordinate.y)
    }

    func antinodes() -> [Coordinate] {
      var antinodes: [Coordinate] = []

      for char in coordinatesByCharacter.keys {
        for pair in pairsForAntenna(character: char) {
//          print("antinodes for \(char) at \(pair[0].x),\(pair[0].y) and \(pair[1].x),\(pair[1].y)")
          antinodes.append(contentsOf: antinodesForPair(a: pair[0], b: pair[1]))
        }
      }
      let inBoundsAntinodes = antinodes.filter { inBounds(coordinate: $0) }
      // Use a set to ignore duplicates
      return Array(Set(inBoundsAntinodes))
    }

    func antinodesPart2() -> [Coordinate] {
      var antinodes: [Coordinate] = []

      for char in coordinatesByCharacter.keys {
        for pair in pairsForAntenna(character: char) {
          antinodes.append(contentsOf: lineOfAntinodesForPair(a: pair[0], b: pair[1]))
        }
      }
      // Use a set to ignore duplicates
      return Array(Set(antinodes))
    }

  }

  class DictGrid<Element>: @unchecked Sendable {
    var grid: [Coordinate: Element]

    let maxPoint: Coordinate

    struct Coordinate: Hashable {
      let x: Int
      let y: Int
    }

    init(grid: [Coordinate : Element], maxPoint: Coordinate) {
      self.grid = grid
      self.maxPoint = maxPoint
    }
  }

  func part1() -> Any {
    return antennaMap.antinodes().count // 359
  }

  func part2() -> Any {
    return antennaMap.antinodesPart2().count // 1293
  }
}
