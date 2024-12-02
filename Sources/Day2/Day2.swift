//
//  Day2.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 02/12/2024.
//

import Foundation
import Parsing
import Utils

@main
public struct Day2 {
  public static func main() throws {
    let input = try Bundle.module.inputString()
    let part1Result = try part1(input)
    print("Part 1: \(part1Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let parsed = try ReportsParser().parse(string)
  return parsed.count(where: { safety(for: $0) == .safe })
}

func safety(for report: Report) -> Report.Safety {
  var lastDirection: Report.Direction?

  for (one, two) in zip(report.levels, report.levels.dropFirst()) {
    let difference = one - two

    if !(1 ... 3).contains(abs(difference)) {
      return .unsafe
    }

    let direction: Report.Direction = if difference > 0 {
      .incremented
    } else {
      .decremented
    }

    if let lastDirection, lastDirection != direction {
      return .unsafe
    }

    lastDirection = direction
  }

  return .safe
}

struct Report {
  let levels: [Int]

  enum Safety {
    case safe
    case unsafe
  }

  enum Direction {
    case incremented
    case decremented
  }
}

struct ReportParser: Parser {
  var body: some Parser<Substring, Report> {
    Parse(Report.init) {
      Many {
        Int.parser()
      } separator: {
        Whitespace(.horizontal)
      } terminator: {
        Whitespace(1, .vertical)
      }
    }
  }
}

struct ReportsParser: Parser {
  var body: some Parser<Substring, [Report]> {
    Many {
      ReportParser()
    } terminator: {
      Whitespace()
    }
  }
}
