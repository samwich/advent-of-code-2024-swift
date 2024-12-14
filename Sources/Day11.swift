import Algorithms

struct Day11: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Int] {
    data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map { Int($0)! }
  }

  func transform(stone: Int) -> [Int] {
    if stone == 0 {
      return [1]
    } else if String(stone).count.isMultiple(of: 2) {
      let s = String(stone)
      let halfCount = s.count / 2
      let first = Int(s.dropLast(halfCount))!
      let second = Int(s.dropFirst(halfCount))!
      return [first, second]
    } else {
      return [stone * 2024]
    }
  }

  func blink1(stones: [Int]) -> [Int] {
    stones.flatMap { transform(stone: $0)}
  }

  func play1(steps: Int, stones: [Int]) -> [Int] {
    var stepStones = stones
    for i in 0..<steps {
      print("Beginning iteration \(i)")
      stepStones = blink1(stones: stepStones)
//      print("i = \(i)")
//      print(stepStones)
    }
    return stepStones
  }

  func part1() -> Any {
    let stones = entities
    return play1(steps: 25, stones: stones).count // 233875
  }

  func part2() -> Any {
    let stones = entities
    return play1(steps: 75, stones: stones).count // 233875
  }
}
