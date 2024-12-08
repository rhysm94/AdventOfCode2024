//
//  Day3Tests.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 03/12/2024.
//

@testable import Day3
import Testing

let testInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

let testInput2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

let testInput3 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))mul(2,3)"

let testInput4 = "xmul(1,3)don't()don't()mul(1,4)don't()do()mul(2,3)"

@Test func part1_sample() throws {
  let part1 = try part1(testInput)
  #expect(part1 == 161)
}

@Test func part2_sample() throws {
  let part2 = try part2(testInput2)
  #expect(part2 == 48)
}

@Test func part2_sample2() throws {
  let part2 = try part2(testInput3)
  #expect(part2 == 54)
}

@Test func part2_sample3() throws {
  let part2 = try part2(testInput4)
  #expect(part2 == 9)
}
