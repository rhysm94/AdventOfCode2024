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

    let part2Result = try part2(input)
    print("Part 2: \(part2Result)")
  }
}

func part1(_ string: String) throws -> Int {
  let extractions = try extractMuls(string)
  return extractions.reduce(0) { partialResult, next in
    partialResult + next.result
  }
}

enum StartToken {
  case `do`
  case `dont`

  struct NoMatch: Error {}

  static let regex = TryCapture {
    ChoiceOf {
      Anchor.startOfLine
      "do()"
      "don't()"
    }
  } transform: { output in
    switch output {
    case "", "do()": Self.do
    case "don't()": Self.dont
    default: throw NoMatch()
    }
  }
}

func part2(_ string: String) throws -> Int {
  let string = string.replacing(.whitespace, with: "")
  enum PartialResult {
    case regex(token: StartToken, range: Range<String.Index>)
    case end

    var token: StartToken {
      switch self {
      case .regex(let token, _): token
      case .end: .do
      }
    }

    func nextIndex(_ string: String) -> String.Index {
      switch self {
      case .regex(_, let range): range.lowerBound
      case .end: string.endIndex
      }
    }
  }

  let splitByStartToken: [PartialResult] = string
    .matches(of: StartToken.regex)
    .map { .regex(token: $0.output.1, range: $0.range) } + [.end]

  struct Section {
    let token: StartToken
    let string: String
  }

  return try zip(splitByStartToken, splitByStartToken.dropFirst())
    .lazy
    .map { lhs, rhs -> Section in
      Section(
        token: lhs.token,
        string: String(
          string[lhs.nextIndex(string) ..< rhs.nextIndex(string)]
        )
      )
    }
    .filter { $0.token == .do }
    .reduce(0) { acc, next in
      try acc + part1(next.string)
    }
}

struct Mul {
  let lhs: Int
  let rhs: Int

  var result: Int { lhs * rhs }

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

func extractMuls(_ string: String) throws -> [Mul] {
  string.matches(of: Mul.regex)
    .map {
      Mul(lhs: $0[Mul.lhsRef], rhs: $0[Mul.rhsRef])
    }
}
