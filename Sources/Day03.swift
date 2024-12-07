import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {

    let r = Regex {
      "mul("
      Capture {
        OneOrMore(.digit)
      } transform: {Int($0)!}
      ","
      Capture {
        OneOrMore(.digit)
      } transform: {Int($0)!}
      ")"
    }

    let instructions = data.matches(of: r)

    return instructions.map {$0.output.1 * $0.output.2}.reduce(0, +) // 169021493
  }

  func part2() -> Any {
    return 0
  }
}
