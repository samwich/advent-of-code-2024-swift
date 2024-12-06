import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  var leftValues: [Int]
  var rightValues: [Int]

  init(data: String) {
    self.data = data
    leftValues = []
    rightValues = []

    for row in data.split(separator: "\n") {
      let values = row.trimmingCharacters(in: .whitespacesAndNewlines)
        .split(separator: " ")
        .compactMap { Int($0) }

      leftValues.append(values[0])
      rightValues.append(values[1])
    }
    leftValues.sort()
    rightValues.sort()
  }

  func part1() -> Any {
    var sumOfDifferences: Int = 0

    for i in (0..<leftValues.count) {
      sumOfDifferences += abs(leftValues[i] - rightValues[i])
    }

    return sumOfDifferences // 3246517
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    return 0
  }
}
