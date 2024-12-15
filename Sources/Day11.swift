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
    for _i in 0..<steps {
//      print("Beginning iteration \(i)")
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

  var entities2: [Substring] {
    data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
  }

  class StoneCounter: @unchecked Sendable {
    var stones: [String: Int]

    init(input: [Substring]) {
      var stones: [String: Int] = [:]
      for s in input {
        stones[String(s)] = 1
      }
      self.stones = stones
    }

    var count: Int {
      stones.values.reduce(0, +)
    }

    func play(steps: Int) {
      var playStones = stones
      for _ in 0..<steps {
        playStones = blink(playStones)
      }
      self.stones = playStones
    }

    func blink(_ stones: [String: Int]) -> [String: Int] {
      let keys = stones.keys
      var blinkStones: [String: Int] = [:]
      for k in keys {
        let stoneCount = stones[k]!
        if stoneCount == 0 { continue }

        // transform k
        let transformed = transform(stone: Int(k)!)
        // we're replacing all of k with the transformed values
//        blinkStones[k] = 0 // for some reason, this is ruining the results
        // store the results
//        print("\(k) became \(transformed)")
        for t in transformed {
          blinkStones[String(t), default: 0] += stoneCount
        }
      }
//      print("blinkStones == stones: \(blinkStones == stones)")
      return blinkStones
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

  }

  func part2() -> Any {
    let counter = StoneCounter(input: entities2)
    counter.play(steps: 75)
    return counter.count // 277444936413293
  }
}
