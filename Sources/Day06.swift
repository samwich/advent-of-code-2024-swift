import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
//  var data: String

  struct Coordinate: Hashable {
    let row: Int
    let col: Int
  }

  struct Location {
    var obstacle = false
    var startPosition = false
    var visited = false
    var enteredVia = [false, false, false, false]
  }

  class Floor: @unchecked Sendable {
    var floor: [Coordinate: Location]

    let startAt: Coordinate
    let boundaries: (Int, Int)
    let directions = [
      (-1, 0), // up
      (0, 1), // right
      (1, 0), // down
      (0, -1) // left
    ]

    let cleanFloor: [Coordinate: Location]
    var loopDetected = false

    var visitCount: Int {
      floor.filter { $0.1.visited }.count
    }

    var visitedLocations: [Coordinate] {
      floor.filter(\.1.visited).map(\.0)
    }

    init(copy cleanFloor: Floor) {
      self.floor = cleanFloor.cleanFloor
      self.cleanFloor = cleanFloor.cleanFloor
      self.startAt = cleanFloor.startAt
      self.boundaries = cleanFloor.boundaries
    }

    init(data: String) {

      var floor: [Coordinate: Location] = [:]
      var start = Coordinate(row: 0, col: 0)

      let entities = data.split(separator: "\n").map {
        $0.split(separator: "")
      }

      for (i, row) in entities.enumerated() {
        for (j, col) in row.enumerated() {
          if col == "." {
            continue
          }
          let coordinate = Coordinate(row: i, col: j)
          var location = Location()
          if col == "^" {
            location.startPosition = true
            start = Coordinate(row: i, col: j)
          }
          if col == "#" {
            location.obstacle = true
          }
          floor[coordinate] = location
        }
      }
      self.floor = floor
      self.cleanFloor = floor
      self.startAt = start
      self.boundaries = (entities.count, entities.first!.count)
    }

    func inBounds(_ coordinate: Coordinate) -> Bool {
      ((0..<boundaries.0-1).contains(coordinate.row)) && ((0..<boundaries.1-1).contains(coordinate.col))
    }

    func run() {
      var coordinate = startAt
      var directionIndex = 0

      var step = 0

      while inBounds(coordinate) {
        step += 1

        let dir = directions[directionIndex]
        let nextCoordinate = Coordinate(row: coordinate.row + dir.0, col: coordinate.col + dir.1)
        let nextLocation = floor[nextCoordinate, default: Location()]
        if nextLocation.obstacle {
          // turn 90º
          directionIndex = (directionIndex + 1) % directions.count
          // continue
        } else {
//          print("enteredVia \(floor[coordinate]!.enteredVia) on step \(step)")
          if nextLocation.enteredVia[directionIndex] {
            loopDetected = true
            return
          }

          // update position
          coordinate = nextCoordinate
          floor[coordinate, default: Location()].visited = true
          floor[coordinate, default: Location()].enteredVia[directionIndex] = true
        }

      }
    }

  }

  var floor: Floor

  init(data: String) {
    self.floor = Floor(data: data)
  }

  func part1() -> Any {
    floor.run()
    return floor.visitCount // 4977
  }

  func part2() -> Any {
    // initialize the visited coordinates
    floor.run()

    // try placing an obstacle in every originally visited location, not including the starting point

    var loopingObstacles: [Coordinate] = []

    for coordinate in floor.visitedLocations {
      // skip the guard's starting location
      if coordinate == floor.startAt {
        print("skipping guard starting location")
        continue
      }

      let f = Floor(copy: floor)
      f.floor[coordinate, default: Location()].obstacle = true
      f.run()
      if f.loopDetected {
        loopingObstacles.append(coordinate)
      }
    }

    return loopingObstacles.count // 1729
  }
}
