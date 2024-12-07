//
//  Day3Tests.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 03/12/2024.
//

@testable import Day3
import Testing

let testInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

@Test func part1_sample() throws {
  let part1 = try part1(testInput)
  #expect(part1 == 161)
}
