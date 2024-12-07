import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Report] {
    data.split(separator: "\n").map {
      Report(levels: $0.split(separator: " ").compactMap { Int($0) } )
    }
  }

  struct Report {
    let levels: [Int]

    var safe: Bool {
      var strategy = 0
      if levels[0] < levels[1] {
        strategy = 1
      } else if levels[0] > levels[1] {
        strategy = -1
      } else {
        return false
      }
      
      let safeRange = 1...3

      for i in 0..<levels.count-2 {
        let delta = levels[i+1] - levels[i]
        if safeRange.contains(delta * strategy) {
          continue
        } else {
          return false
        }
      }
      
      return true
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {

    return entities.filter(\.safe).count // 394 is too high
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    return 0
  }
}
