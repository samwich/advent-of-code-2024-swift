import Algorithms

struct Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Int] {
    data.split(separator: "").compactMap { Int($0) }
  }

  func part1() -> Any {
    let decoded = entities
    var drive: [Int?] = []

    // decode input into drive
    for i in 0..<decoded.count {
      if i.isMultiple(of: 2) {
        drive = drive + Array(repeating: i/2, count: decoded[i])
      } else {
        drive = drive + Array(repeating: nil, count: decoded[i])
      }
    }

//    print(drive)

    // compact the drive
    var i = 0
    var j = drive.count - 1
    while i < j {
      if drive[i] != nil {
        i += 1
        continue
      }
      if drive[j] == nil {
        j -= 1
        continue
      }
      drive.swapAt(i, j)
      i += 1
      j -= 1
    }

//    print(drive)

    // calculate checksum
    var checksum = 0
    for i in 0..<drive.count {
      if let value = drive[i] {
        checksum += i * value
      }
    }

    return checksum // 6360094256423
  }

  func part2() -> Any {
    return 0
  }
}
