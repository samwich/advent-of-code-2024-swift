import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day10Tests {
  // Smoke test data provided in the challenge question
  let testData1 = """
    0123
    1234
    8765
    9876
    """

  let testData2 = """
    ...0...
    ...1...
    ...2...
    6543456
    7.....7
    8.....8
    9.....9
    """

  let testData3 = """
    ..90..9
    ...1.98
    ...2..7
    6543456
    765.987
    876....
    987....
    """

  let testData4 = """
    10..9..
    2...8..
    3...7..
    4567654
    ...8..3
    ...9..2
    .....01
    """

  let testData5 = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

  let testData6 = """
    .....0.
    ..4321.
    ..5..2.
    ..6543.
    ..7..4.
    ..8765.
    ..9....
    """

  let testData7 = """
    ..90..9
    ...1.98
    ...2..7
    6543456
    765.987
    876....
    987....
    """

  let testData8 = """
    012345
    123456
    234567
    345678
    4.6789
    56789.
    """

  @Test func testPart1() async throws {
    let c1 = Day10(data: testData1)
    let c2 = Day10(data: testData2)
    let c3 = Day10(data: testData3)
    let c4 = Day10(data: testData4)
    let c5 = Day10(data: testData5)
    #expect(String(describing: c1.part1()) == "1")
    #expect(String(describing: c2.part1()) == "2")
    #expect(String(describing: c3.part1()) == "4")
    #expect(String(describing: c4.part1()) == "3")
    #expect(String(describing: c5.part1()) == "36")
  }

  @Test func testPart2() async throws {
    let challenge = Day10(data: testData5)
    #expect(String(describing: challenge.part2()) == "81")
    let c6 = Day10(data: testData6)
    let c7 = Day10(data: testData7)
    let c8 = Day10(data: testData8)
    #expect(String(describing: c6.part2()) == "3")
    #expect(String(describing: c7.part2()) == "13")
    #expect(String(describing: c8.part2()) == "227")
  }
}
