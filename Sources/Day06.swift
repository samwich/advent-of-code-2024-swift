import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct Point {
    let row: Int
    let col: Int
//    var visited = false
  }

  var floor: [Int: [Int: Bool]]
  let startingPosition: (Int, Int)
  let boundaries: (Int, Int)

  init(data: String) {

    var floor: [Int: [Int: Bool]] = [:]
    var start = (0,0)

    let entities = data.split(separator: "\n").map {
      $0.split(separator: "")
    }

    for (i, row) in entities.enumerated() {
      for (j, col) in row.enumerated() {
        if col == "^" {
          start = (i, j)
        }
        if col == "#" {
          floor[i, default: [:]][j] = true
        }
      }
    }

    self.data = data
    self.floor = floor
    self.startingPosition = start
    self.boundaries = (entities.count, entities.first!.count)
  }

  func part1() -> Any {
    var position = startingPosition
    var visited: Set<Point> = [Point(row: startingPosition.0, col: startingPosition.1)]

    let directions = [
      (-1, 0), // up
      (0, 1), // right
      (1, 0), // down
      (0, -1) // left
    ]

    var directionIndex = 0

    while ((0..<boundaries.0-1).contains(position.0)) && ((0..<boundaries.1-1).contains(position.1)) {
      let dir = directions[directionIndex]
      let (nextR, nextC) = (position.0 + dir.0, position.1 + dir.1)
      if let _ = floor[nextR]?[nextC] {
        // turn 90º
        directionIndex = (directionIndex + 1) % directions.count
        // continue
      } else {
        // update position
        position = (nextR, nextC)
        // add to visited list
        visited.insert(Point(row: nextR, col: nextC))
      }
    }

    return visited.count // 4977
  }

  func part2() -> Any {
    return 0
  }
}

extension Day06.Point: Hashable {
  static func == (lhs: Day06.Point, rhs: Day06.Point) -> Bool {
    return lhs.row == rhs.row && lhs.col == rhs.col
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(row)
    hasher.combine(col)
  }
}
