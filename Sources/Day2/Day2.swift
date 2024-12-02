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

    let part2Result = try part2(input)
    print("Part 2: \(part2Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let parsed = try ReportsParser().parse(string)
  let safe = parsed.map(safety).map(\.incidentCount).count(where: { $0 == 0 })
  return safe
}

func part2(_ string: String) throws -> Int {
  let parsed = try ReportsParser().parse(string)
  let reportWithSafety = zip(parsed, parsed.map(safety))

  let safe = reportWithSafety.count(where: { $1.incidentCount == 0 })
  let partlySafe = reportWithSafety
    .filter { $1.incidentCount > 0 }
    .count { report, _ in
      for index in report.levels.indices {
        var newReport = report
        newReport.levels.remove(at: index)
        let newCounter = safety(for: newReport)
        if newCounter.incidentCount == 0 {
          return true
        }
      }

      return false
    }

  return safe + partlySafe
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
  var levels: [Int]

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
