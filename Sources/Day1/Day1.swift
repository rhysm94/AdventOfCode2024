//
//  Day1.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 01/12/2024.
//

import Foundation
import Parsing

@main
public struct Day1 {
  public static func main() throws {
    guard let data = Bundle.module.url(forResource: "input", withExtension: "txt") else {
      return
    }

    let input = try String(contentsOf: data, encoding: .utf8)

    let part1Result = try part1(input)
    print("Part 1: \(part1Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let parsed = try ElementsParser().parse(string)
  let lhsSorted = parsed.map(\.lhs).sorted()
  let rhsSorted = parsed.map(\.rhs).sorted()

  let partWay = zip(lhsSorted, rhsSorted).map { lhs, rhs in
    if lhs > rhs {
      lhs - rhs
    } else {
      rhs - lhs
    }
  }

  return partWay.reduce(0, +)
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
      "\n"
    }

    "\n"
  }
}
