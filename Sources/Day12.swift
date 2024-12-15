import Algorithms

struct Day12: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Substring]] {
    data.split(separator: "\n").map {
      $0.split(separator: "")
    }
  }

  class Garden {
    var grid: [Point: Plot]
//    var perimeters: [Int: Int]
    var regions: [Int: [Point]]
    let xCount: Int
    let yCount: Int

    var price: Int {
      regions.keys.map { areaForRegion($0) * perimeterForRegion($0) }.reduce(0,+)
    }

    func areaForRegion(_ regionId: Int) -> Int {
      regions[regionId]!.count
    }

    func perimeterForRegion(_ regionId: Int) -> Int {
      regions[regionId]!.map { grid[$0]!.fences }.reduce(0,+)
    }


    init(entities: [[Substring]]) {
      var grid: [Point: Plot] = [:]
      var regions: [Int: [Point]] = [:]
//      var perimeters: [Int: Int] = [:]
      let xCount = entities.first!.count
      let yCount = entities.count

      for y in entities.indices {
        for x in entities[y].indices {
          let point = Point(x: x, y: y)
          let plot = Plot(x: x, y: y, entities: entities)
          grid[point] = plot
        }
      }

      for y in entities.indices {
        for x in entities[y].indices {
          let point = Point(x: x, y: y)
          // skip if the point is already part of a region
          if grid[point]!.regionId != nil { continue }

          // make a new region
          var regionId: Int
          if regions.keys.count == 0 {
            regionId = 0
          } else {
            regionId = regions.keys.max()! + 1
          }
          regions[regionId] = []
//          regions[regionId]!.append(point)
          var plot = grid[point]!
          plot.regionId = regionId


          // do some kind of flood fill via the plot's neighbors

          var unexploredNeighbors = [point]
          while unexploredNeighbors.count > 0 {

            let thisPoint = unexploredNeighbors.removeLast()

            if grid[thisPoint]!.regionId != nil { continue }

            // add the point to the region
            regions[regionId]!.append(thisPoint)

            // add the region to the plot at the point
            grid[thisPoint]!.regionId = regionId

            // add the plot's neighbors to the list
            unexploredNeighbors += grid[thisPoint]!.neighbors.filter({ grid[$0]!.regionId == nil })

          }
          // add perimeters for each plot as it's created?

        }
      }

      self.grid = grid
      self.regions = regions
//      self.perimeters = perimeters
      self.xCount = xCount
      self.yCount = yCount
    }

  }

  struct Plot {
    let x: Int
    let y: Int
    let plant: String
    var regionId: Int?
    let neighbors: [Point]
    let fences: Int

    init (x: Int, y: Int, entities: [[Substring]]) {
      self.x = x
      self.y = y
      self.plant = String(entities[y][x])
      self.regionId = nil

      let xCount = entities.first!.count
      let yCount = entities.count
      var neighbors: [Point] = []
      if x > 0        && entities[y][x-1] == plant { neighbors.append(Point(x: x - 1, y: y)) }
      if x < xCount-1 && entities[y][x+1] == plant { neighbors.append(Point(x: x + 1, y: y)) }
      if y > 0        && entities[y-1][x] == plant { neighbors.append(Point(x: x, y: y - 1)) }
      if y < yCount-1 && entities[y+1][x] == plant { neighbors.append(Point(x: x, y: y + 1)) }

      self.neighbors = neighbors
      self.fences = 4 - neighbors.count
    }
  }

  struct Point: Hashable {
    let x: Int
    let y: Int
  }

  func part1() -> Any {
    let g = Garden(entities: entities)
    return g.price // 1415378
  }

  func part2() -> Any {
    return 0
  }
}
