//
//  Day3.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 03/12/2024.
//

import Foundation
@preconcurrency import RegexBuilder
import Utils

@main
public struct Day3 {
  public static func main() throws {
    let input = try Bundle.module.inputString()

    let part1Result = try part1(input)
    print("Part 1: \(part1Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let extractions = try extract(string)
  return extractions.reduce(0) { partialResult, next in
    partialResult + next.result
  }
}

struct Mul {
  let lhs: Int
  let rhs: Int

  var result: Int {
    lhs * rhs
  }

  static let lhsRef = Reference(Int.self)
  static let rhsRef = Reference(Int.self)

  nonisolated(unsafe) static let regex = Regex {
    "mul("

    TryCapture(as: lhsRef) {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }

    ","

    TryCapture(as: rhsRef) {
      OneOrMore(.digit)
    } transform: { match in
      Int(match)
    }

    ")"
  }
}

func extract(_ string: String) throws -> [Mul] {
  string.matches(of: Mul.regex)
    .map {
      Mul(lhs: $0[Mul.lhsRef], rhs: $0[Mul.rhsRef])
    }
}
