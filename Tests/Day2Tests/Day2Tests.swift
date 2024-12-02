//
//  Day2Tests.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 02/12/2024.
//

@testable import Day2
import Testing

let testInput = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9

"""

@Test func part1_sample() throws {
  let part1 = try part1(testInput)
  #expect(part1 == 2)
}

@Test func part2_sample() throws {
  let part2 = try part2(testInput)
  #expect(part2 == 4)
}
