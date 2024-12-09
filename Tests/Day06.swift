import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day06Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  let loopTestData = """
  .#..
  #^.#
  ..#.
  """

  @Test func testPart1() async throws {
    let challenge = Day06(data: testData)
    #expect(String(describing: challenge.part1()) == "41")
  }

  @Test func testDetectLoop() async throws {
    let floor = Day06.Floor(data: loopTestData)
    floor.run()
    #expect(floor.loopDetected)
  }

  @Test func testPart2() async throws {
    let challenge = Day06(data: testData)
    #expect(String(describing: challenge.part2()) == "6")
  }
}
