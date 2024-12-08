import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day04Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  let testData0 = """
    ..X...
    .SAMX.
    .A..A.
    XMAS.S
    .X....
    """

  let testData3 = """
    X.SXS.
    M.MAX.
    AAM.M.
    SX..AX
    ....S.
    """

  @Test func testPart0() async throws {
    let challenge = Day04(data: testData0)
    #expect(String(describing: challenge.part1()) == "4")
  }

  @Test func testPart3() async throws {
    let challenge = Day04(data: testData3)
    #expect(String(describing: challenge.part1()) == "5")
  }

  @Test func testPart1() async throws {
    let challenge = Day04(data: testData)
    #expect(String(describing: challenge.part1()) == "18")
  }

  @Test func testPart2() async throws {
    let challenge = Day04(data: testData)
    #expect(String(describing: challenge.part2()) == "9")
  }
}
