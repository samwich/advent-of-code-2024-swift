import Algorithms
import RegexBuilder

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    let matrix = data.split(separator: "\n").map { $0.split(separator: "")}

    let limitTop = 2
    let limitBottom = matrix.count - 3
    let limitLeft = 2
    let limitRight = matrix[0].count - 3

    var total = 0

    for r in 0..<matrix.count {
      let row = matrix[r]
      for c in 0..<row.count {
        let cell = row[c]
        if cell == "X" {
          // to the right
          if c < limitRight  && matrix[r][c+1] == "M" && matrix[r][c+2] == "A" && matrix[r][c+3] == "S" { total += 1 }
          // to the left
          if c > limitLeft   && matrix[r][c-1] == "M" && matrix[r][c-2] == "A" && matrix[r][c-3] == "S" { total += 1 }
          // top down
          if r < limitBottom && matrix[r+1][c] == "M" && matrix[r+2][c] == "A" && matrix[r+3][c] == "S" { total += 1 }
          // bottom up
          if r > limitTop    && matrix[r-1][c] == "M" && matrix[r-2][c] == "A" && matrix[r-3][c] == "S" { total += 1 }
          // upper-left to lower-right
          if r < limitBottom && c < limitRight && matrix[r+1][c+1] == "M" && matrix[r+2][c+2] == "A" && matrix[r+3][c+3] == "S" {total += 1}
          // upper-right to lower-left
          if r < limitBottom && c > limitLeft  && matrix[r+1][c-1] == "M" && matrix[r+2][c-2] == "A" && matrix[r+3][c-3] == "S" {total += 1}
          // lower-left to upper-right
          if r > limitTop && c < limitRight    && matrix[r-1][c+1] == "M" && matrix[r-2][c+2] == "A" && matrix[r-3][c+3] == "S" {total += 1}
          // lower-right to upper-left
          if r > limitTop && c > limitLeft     && matrix[r-1][c-1] == "M" && matrix[r-2][c-2] == "A" && matrix[r-3][c-3] == "S" {total += 1}
        }
      }
    }

    return total // 2532
  }

  func part2() -> Any {
    let matrix = data.split(separator: "\n").map { $0.split(separator: "")}
    var total = 0

    for r in 1..<matrix.count-1 {
      let row = matrix[r]
      for c in 1..<row.count-1 {
        if matrix[r][c] == "A" {
          if ((matrix[r-1][c-1] == "M" && matrix[r+1][c+1] == "S") ||
              (matrix[r+1][c+1] == "M" && matrix[r-1][c-1] == "S")) &&
             ((matrix[r-1][c+1] == "M" && matrix[r+1][c-1] == "S") ||
              (matrix[r+1][c-1] == "M" && matrix[r-1][c+1] == "S")) {
            total += 1
          }
        }
      }
    }

    return total // 1941
  }
}
