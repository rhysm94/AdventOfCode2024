//
//  InputString.swift
//  AdventOfCode2024
//
//  Created by Rhys Morgan on 02/12/2024.
//

import Foundation

public extension Bundle {
  func inputString() throws -> String {
    guard let url = url(forResource: "input", withExtension: "txt") else {
      throw MissingFile()
    }

    return try String(contentsOf: url, encoding: .utf8)
  }
}

public struct MissingFile: Error, LocalizedError {
  public var errorDescription: String? {
    "Missing input file"
  }

  public var recoverySuggestion: String? {
    "Check you've definitely added the input.txt file"
  }
}
