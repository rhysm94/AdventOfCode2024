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
  let safe = parsed.map(safety).map(\.incidentCount).count(where: { $0 == 0 })
  return safe
}

struct SafetyCounter {
  var direction: Report.Direction?
  var incidentCount: Int = 0
}

func safety(for report: Report) -> SafetyCounter {
  zip(report.levels, report.levels.dropFirst())
    .reduce(into: SafetyCounter()) { counter, next in
      let (one, two) = next
      let difference = one - two
      
      if !(1 ... 3).contains(abs(difference)) {
        counter.incidentCount += 1
        return
      }

      let direction: Report.Direction = if difference > 0 {
        .incremented
      } else {
        .decremented
      }

      if let lastDirection = counter.direction, lastDirection != direction {
        counter.incidentCount += 1
        return
      }

      counter.direction = direction
    }
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
