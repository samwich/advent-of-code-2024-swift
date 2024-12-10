import Algorithms

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var entities: [Equation] {
    data.split(separator: "\n").map {
      let args = $0.split(separator: #/:| /#).compactMap { Int($0) }
      return Equation(result: args[0], inputs: Array(args.dropFirst()))
    }
  }

  struct Equation {
    let result: Int
    let inputs: [Int]

    var operators: [(Int, Int) -> Int] = [{$0 + $1}, {$0 * $1}]

    var equal: Bool {
      check(elements: inputs)
    }

    func check(elements: [Int]) -> Bool {
//      print(elements)
//      print("\(operators.count) operators")

      // combine the first two elements and then pass the rest of the list into myself
      for o in operators {

        // combine the first two
        let r = o(elements[0], elements[1])

//        print("\(result): \(elements[0]) and \(elements[1]) -> \(r)")

        // base case
        if elements.count == 2 {
          if r == result {
            return true
          }
        } else {
          if check(elements: [r] + elements[2...]) {
            return true
          }
        }
      }
      // no match found
      return false
    }

  }

  func concatenate(_ a: Int, _ b: Int) -> Int {
    let digitCount = String(b).count
    var bigA = a
    for _ in 0..<digitCount {
      bigA *= 10
    }

    return bigA + b
  }

  func part1() -> Any {
    return entities.filter(\.equal).map(\.result).reduce(0, +) // 1430271835320
  }

  func part2() -> Any {
    let operators: [(Int, Int) -> Int] = [{$0 + $1}, {$0 * $1}, concatenate]
    return entities.map {
      var e = $0
      e.operators = operators
      return e
    }.filter(\.equal).map(\.result).reduce(0, +) // 456565678667482
  }
}
