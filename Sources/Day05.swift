import Algorithms

struct Day05: AdventDay {
  var data: String
  let entities: [[Substring]]
  let beforeRules: [Int: Set<Int>]
  let updates: [[Int]]

  init(data: String) {
    self.data = data
    entities = data.split(separator: "\n\n").map {
      $0.split(separator: "\n")
    }
    var rules: [Int: Set<Int>] = [:]
    for r in entities.first! {
      let pair = r.split(separator: "|").map { Int($0)! }
      let (a, b) = (pair.first!, pair.last!)
      rules[a, default: []].insert(b)
    }
    beforeRules = rules
    updates = entities.last!.map {
      $0.split(separator: ",").map { Int($0)! }
    }
  }

  func part1() -> Any {
    var middleNumberSum = 0

    updateLoop: for update in updates {
      for (i, page) in update.enumerated() {
        // if there are rules for this page number
        if let myRules = beforeRules[page] {
          // check that I should not be before each preceding page
          for j in 0..<i {
            let n = update[j]
            if myRules.contains(n) {
//              print("\(n) should be after \(page)")
              continue updateLoop
            }
          }
        } else {
          print("no rules for \(page)")
        }
      }
      // add the middle number to middleNumberSum
      let middleIndex = update.count / 2
      middleNumberSum += update[middleIndex]
    }

    return middleNumberSum // 5991
  }

  func part2() -> Any {
    return "part2 not implemented"
  }

}
