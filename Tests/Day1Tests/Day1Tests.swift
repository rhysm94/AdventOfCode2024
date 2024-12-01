//
//  Day1Tests.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 01/12/2024.
//

@testable import Day1
import Testing

let testInput = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

@Test func part1_sample() throws {
  let part1 = try part1(testInput)
  #expect(part1 == 11)
}

@Test func part2_sample() throws {
  let part2 = try part2(testInput)
  #expect(part2 == 31)
}
