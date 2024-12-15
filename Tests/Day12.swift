import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day12Tests {
  // Smoke test data provided in the challenge question
  let example1Data = """
    AAAA
    BBCD
    BBCC
    EEEC
    """

  let example2Data = """
    OOOOO
    OXOXO
    OOOOO
    OXOXO
    OOOOO
    """

  let example3Data = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

  @Test func testPart1ex1() async throws {
    let challenge = Day12(data: example1Data)
    #expect(String(describing: challenge.part1()) == "140")
  }

  @Test func testPart1ex2() async throws {
    let challenge = Day12(data: example2Data)
    #expect(String(describing: challenge.part1()) == "772")
  }

  @Test func testPart1ex3() async throws {
    let challenge = Day12(data: example3Data)
    #expect(String(describing: challenge.part1()) == "1930")
  }

  @Test func testPart2() async throws {
    let challenge = Day12(data: example3Data)
    #expect(String(describing: challenge.part2()) == "part2")
  }
}
