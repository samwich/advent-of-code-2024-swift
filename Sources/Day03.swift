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

    let r = Regex {
      ChoiceOf {
        /(don't)/
        /(do)/
        Regex {
          Capture { "mul" }
          "("
          Capture {
            OneOrMore(.digit)
          } transform: {Int($0)!}
          ","
          Capture {
            OneOrMore(.digit)
          } transform: {Int($0)!}
          ")"
        }
      }
    }

    let instructions = data.matches(of: r)

    var enable = true
    var total = 0

    for instruction in instructions {
      switch instruction.output {
      case (_, "don't"?, nil, nil, nil, nil):
        enable = false
      case (_, nil, "do"?, nil, nil, nil):
        enable = true
      case (_, nil, nil, "mul"?, let arg1, let arg2):
        if enable {
          total += arg1! * arg2!
        }
      default:
        print("unknown")
      }
    }

    return total // 111762583
  }
}
