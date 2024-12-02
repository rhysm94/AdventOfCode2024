//
//  Day1.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 01/12/2024.
//

import Foundation
import Parsing
import Utils

@main
public struct Day1 {
  public static func main() throws {
    let input = try Bundle.module.inputString()

    let part1Result = try part1(input)
    print("Part 1: \(part1Result)")

    let part2Result = try part2(input)
    print("Part 2: \(part2Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let parsed = try ElementsParser().parse(string)
  let lhsSorted = parsed.map(\.lhs).sorted()
  let rhsSorted = parsed.map(\.rhs).sorted()

  return zip(lhsSorted, rhsSorted).map { lhs, rhs in
    if lhs > rhs {
      lhs - rhs
    } else {
      rhs - lhs
    }
  }
  .reduce(0, +)
}

func part2(_ string: String) throws -> Int {
  let parsed = try ElementsParser().parse(string)
  let lhs = parsed.map(\.lhs)
  let rhs = parsed.map(\.rhs)

  return lhs.map { lhs in
    let count = rhs.count(where: { $0 == lhs })
    return lhs * count
  }
  .reduce(0, +)
}

struct Element {
  let lhs: Int
  let rhs: Int
}

struct ElementParser: Parser {
  var body: some Parser<Substring, Element> {
    Parse(Element.init) {
      Int.parser()
      Whitespace()
      Int.parser()
    }
  }
}

struct ElementsParser: Parser {
  var body: some Parser<Substring, [Element]> {
    Many {
      ElementParser()
    } separator: {
      Whitespace()
    } terminator: {
      Whitespace()
    }
  }
}
