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

  //  struct Drive {
  //    var media: [Part2File]
  //  }
  //
  //  struct Part2File {
  //    let id: Int?
  //    let count: Int
  //  }

  func part2() -> Any {
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

    // defrag the drive
    var i = 0
    var j = drive.count - 1
    var spaceNeeded = 0
    while i < j && j >= 0 {
      // point to the current highest untried file
      if drive[j] != nil && j > 0 {
        // measure the size of the current file
        var jStart = j
        while jStart > 0 && drive[jStart] == drive[j] { jStart -= 1 }
        spaceNeeded = j - jStart

        // find a free space that will fit the current file
        // look for a free space
        i = 0
        while i < j && (i + spaceNeeded-1) < drive.count {
          // fast forward to the first free block. this might try to read off the end
          while drive[i] != nil { i += 1 }
//          printDrive(drive, pointers: [(i, "i"), (i+spaceNeeded, "I"),(jStart,"J"), (j, "j")])

          // if we find one, swap the file and free blocks
          if i > j { break }


          if (i + spaceNeeded-1) < drive.count && drive[i...(i+spaceNeeded-1)].allSatisfy({ $0 == nil }) {
            // do the swap
            for blockIndex in 0..<spaceNeeded {
              drive.swapAt(blockIndex + i, blockIndex + jStart + 1)
            }
            // break out to move on to the next file
            break
          } else {
            // advance in the hope that we find a large enough space later
            i += 1
          }
        }
        // whether we did a swap or not, move on to the next file
        if jStart > 0 {
          j = jStart
        } else {
          j = 0
        }
        // reset i
        i = 0
      } else {
        j -= 1
      }
//      printDrive(drive, pointers: [(i, "i"), (j, "j")])
    }

//    print(drive)

    // calculate checksum
    var checksum = 0
    for i in 0..<drive.count {
      if let value = drive[i] {
        checksum += i * value
      }
    }

    return checksum // 6379677752410
  }

  func printDrive(_ drive: [Int?], pointers: [(Int, String)]) {
    let step = drive.map {
      if let value = $0 {
        String(value)
      } else {
        "."
      }
    }

    var result = [step.joined()]

    for p in pointers {
      let (i, s) = p
      if (0..<step.count).contains(i) {
        var a = Array(repeating: ".", count: step.count)
        a[i] = s
        result.append(a.joined())
      } else {
        result.append("\(s) is out of bounds \(i) of \(step.count)")
      }
    }
    print(result.joined(separator: "\n"))
  }
}
