import Algorithms

struct Day05: AdventDay {
  var data: String
  let entities: [[Substring]]
  let beforeRules: [Int: Set<Int>]
  let updates: [Update]

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
      let pageNumbers = $0.split(separator: ",").map { Int($0)! }
      return Update(rules: rules, pages: pageNumbers)
    }
  }

  struct Update {
    let rules: [Int: Set<Int>]
    let corrected: Bool
    var pages: [Int]

    var middleNumber: Int {
      let middleIndex = pages.count / 2
      return pages[middleIndex]
    }

    init(rules: [Int : Set<Int>], pages: [Int]) {
      var corrected = false

      for i in 0..<pages.count {
        let page = pages[i]
        // if there are rules for this page number
        if let myRules = rules[page] {
          // check that I should not be before each preceding page
          for j in 0..<i {
            let n = pages[j]
            if myRules.contains(n) {
              corrected = true
            }
          }
        } else {
          print("no rules for \(page)")
        }
      }

      self.rules = rules
      self.pages = pages
      self.corrected = corrected
    }

  }

  func part1() -> Any {
    var middleNumberSum = 0

    for update in updates {
      if !update.corrected {
        middleNumberSum += update.middleNumber
      }
    }

    return middleNumberSum // 5991
  }

  func part2() -> Any {
    var middleNumberSum = 0



    return middleNumberSum //
  }

}
