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
    let safeDelta = 1...3

    var safe: Bool {
      var strategy = 0
      if levels[0] < levels[levels.endIndex-1] {
        strategy = 1
      } else if levels[0] > levels[levels.endIndex-1] {
        strategy = -1
      } else {
        return false
      }
      
      for i in 0..<levels.count-1 {
        let delta = levels[i+1] - levels[i]
        if safeDelta.contains(delta * strategy) {
          continue
        } else {
          return false
        }
      }
      
      return true
    }

    var safeWithProblemDampener: Bool {
      if safe {
        return true
      }

      for i in 0..<levels.count {
        var modified = levels
        modified.remove(at: i)
        let r = Report(levels: modified)
        if r.safe {
          return true
        }
      }

      return false
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {

    return entities.filter(\.safe).count // 371
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Worst possible performance for input where deleting 1 level would result in a safe report:
    // try deleting each level in turn and re-run the entire report
    // I think that would be O(n^2).
    // Best possible performance would be O(n). We could use a sliding window of 3 levels to
    // assess whether the report is safe or whether a single deletion could make it safe. We can
    // keep track of the number of "correctable" levels in the outer loop and return unsafe if it's higher than 1.
    // The center element of the window could be the one we're working with. In fact, this might not be a window at all.
    // Instead of a window, there could just be special case for the first and last level.
    // I can imagine there being 3 levels that would have multiple valid deletions.
    // Maybe I could spend some time characterizing the input.
    // I'm guessing there's a two-pointer algorithm that solves this.

    // Every report where the first and last levels are the same also has another problem making it unsafe.
    //

    // In the end, I just did brute force.

    let safeWithDamper = entities.filter(\.safeWithProblemDampener).count
    print("Safe with dampener: \(safeWithDamper) of \(entities.count)")
    return safeWithDamper // 426
  }
}
