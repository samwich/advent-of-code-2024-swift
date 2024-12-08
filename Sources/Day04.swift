import Algorithms
import RegexBuilder

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    let width = data.split(separator: "\n").first!.count
    print("width: \(width)")
    let verticalOffset = width - 1
    let diagonalDownRightOffset = width
    let diagonalDownLeftOffset = width - 2

    let noNewLines = data.replacingOccurrences(of: "\n", with: "")

    let rhf = try! Regex("XMAS")
    let rhb = try! Regex("SAMX")
    let rvf = try! Regex("X.{\(verticalOffset)}M.{\(verticalOffset)}A.{\(verticalOffset)}S")
    let rvb = try! Regex("S.{\(verticalOffset)}A.{\(verticalOffset)}M.{\(verticalOffset)}X")
    let rdnw = try! Regex("X.{\(diagonalDownRightOffset)}M.{\(diagonalDownRightOffset)}A.{\(diagonalDownRightOffset)}S")
    let rdne = try! Regex("X.{\(diagonalDownLeftOffset) }M.{\(diagonalDownLeftOffset) }A.{\(diagonalDownLeftOffset) }S")
    let rdsw = try! Regex("S.{\(diagonalDownLeftOffset) }A.{\(diagonalDownLeftOffset) }M.{\(diagonalDownLeftOffset) }X")
    let rdse = try! Regex("S.{\(diagonalDownRightOffset)}A.{\(diagonalDownRightOffset)}M.{\(diagonalDownRightOffset)}X")

    let hf = noNewLines.matches(of: rhf)
    let hb = noNewLines.matches(of: rhb)
    let vf = noNewLines.matches(of: rvf)
    let vb = noNewLines.matches(of: rvb)
    let dnw = noNewLines.matches(of: rdnw)
    let dne = noNewLines.matches(of: rdne)
    let dsw = noNewLines.matches(of: rdsw)
    let dse = noNewLines.matches(of: rdse)

//    let total = [hf, hb, vf, vb, dnw, dse, dne, dsw].map(\.count).reduce(0, +)

//    print("hf: \(hf.count)")
//    print("hb: \(hb.count)")
//    print("vf: \(vf.count)")
//    print("vb: \(vb.count)")
//    print("dnw: \(dnw.count)")
//    print("dne: \(dne.count)")
//    print("dsw: \(dsw.count)")
//    print("dse: \(dse.count)")

//    print("hf: \(hf.count)\nhb: \(hb.count)\nvf: \(vf.count)\nvb: \(vb.count)\ndnw: \(dnw.count)\ndne: \(dne.count)\ndsw: \(dsw.count)\ndse: \(dse.count)\nTotal: \(total)")

    let word = ["X", "M", "A", "S"].map(Character.init)
    var xmasTotal = 0

    let north = -1 * width
    let south = width
    let east = 1
    let west = -1
    let northEast = north + east
    let northWest = north + west
    let southEast = south + east
    let southWest = south + west

    let asCharacters = noNewLines.map(Character.init)
    var foundWords: [[(Int, Character)]] = []

    for i in 0..<asCharacters.count {
      // If it's an "X", try to make some XMASes
      if asCharacters[i] == word[0] {
        // iterate through each direction
        for direction in [north, south, east, west, northEast, northWest, southEast, southWest] {
          // try to spell the word
          var myWord = [(i, word[0])]
          for wi in 1..<4 {
            let j = i + (direction * wi)
            // don't go out of bounds
            if j < 0 || j >= asCharacters.count {
              break
            }
            if asCharacters[j] == word[wi] {
              myWord.append((j, word[wi]))
              if wi == 3 {
                xmasTotal += 1
                foundWords.append(myWord)
              }
            } else {
              break
            }
          }

        }

      }
    }

    for f in foundWords {
      print(f)
    }

    return xmasTotal // 2549 is too high
  }

  func part2() -> Any {
    return 0
  }
}
