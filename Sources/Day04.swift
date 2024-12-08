import Algorithms
import RegexBuilder

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    let width = data.split(separator: "\n").first!.count
    print("width: \(width)")

    let noNewLines = data.replacingOccurrences(of: "\n", with: "")

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

//    for f in foundWords {
//      print(f)
//    }
//    print(asCharacters.filter{$0 == Character("X")}.count)
    
    print(xmasTotal) // 2549 is too high


    let matrix = data.split(separator: "\n").map { $0.split(separator: "")}

    let limitTop = 2
    let limitBottom = matrix.count - 3
    let limitLeft = 2
    let limitRight = matrix[0].count - 3

    var total2 = 0

    for r in 0..<matrix.count {
      let row = matrix[r]
      for c in 0..<row.count {
        let cell = row[c]
        if cell == "X" {
          // to the right
          if c < limitRight  && matrix[r][c+1] == "M" && matrix[r][c+2] == "A" && matrix[r][c+3] == "S" { total2 += 1 }
          // to the left
          if c > limitLeft   && matrix[r][c-1] == "M" && matrix[r][c-2] == "A" && matrix[r][c-3] == "S" { total2 += 1 }
          // top down
          if r < limitBottom && matrix[r+1][c] == "M" && matrix[r+2][c] == "A" && matrix[r+3][c] == "S" { total2 += 1 }
          // bottom up
          if r > limitTop    && matrix[r-1][c] == "M" && matrix[r-2][c] == "A" && matrix[r-3][c] == "S" { total2 += 1 }
          // upper-left to lower-right
          if r < limitBottom && c < limitRight && matrix[r+1][c+1] == "M" && matrix[r+2][c+2] == "A" && matrix[r+3][c+3] == "S" {total2 += 1}
          // upper-right to lower-left
          if r < limitBottom && c > limitLeft  && matrix[r+1][c-1] == "M" && matrix[r+2][c-2] == "A" && matrix[r+3][c-3] == "S" {total2 += 1}
          // lower-left to upper-right
          if r > limitTop && c < limitRight    && matrix[r-1][c+1] == "M" && matrix[r-2][c+2] == "A" && matrix[r-3][c+3] == "S" {total2 += 1}
          // lower-right to upper-left
          if r > limitTop && c > limitLeft     && matrix[r-1][c-1] == "M" && matrix[r-2][c-2] == "A" && matrix[r-3][c-3] == "S" {total2 += 1}
        }
      }
    }

    return total2 // 2532
  }

  func part2() -> Any {
    return 0
  }
}
